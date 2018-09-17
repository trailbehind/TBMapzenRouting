//
//  TBMapzenRoutingPolylineUtils.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 9/17/18.
//  Copyright © 2018 Trailbehind inc. All rights reserved.
//

#import "TBMapzenRoutingPolylineUtils.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation TBMapzenRoutingPolylineUtils

static const double precision = 1e-6;

+ (CLLocationCoordinate2D*)decodePolyline:(NSString*)polyline length:(NSUInteger*)outputLength {
  const char *bytes = [polyline UTF8String];
  NSUInteger length = [polyline lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
  
  NSUInteger allocCount = length/4;
  CLLocationCoordinate2D *coords = calloc(allocCount, sizeof(CLLocationCoordinate2D));
  
  NSUInteger idx = 0;
  NSUInteger coordIdx = 0;
  
  CGFloat latitude = 0;
  CGFloat longitude = 0;
  while (idx < length) {
    char byte = 0;
    int res = 0;
    char shift = 0;
    
    do {
      byte = bytes[idx++] - 63;
      res |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    
    float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
    latitude += deltaLat;
    
    shift = 0;
    res = 0;
    
    do {
      byte = bytes[idx++] - 0x3F;
      res |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    
    float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
    longitude += deltaLon;
    
    coords[coordIdx++] = CLLocationCoordinate2DMake(latitude * precision, longitude * precision);
    
    if (coordIdx == allocCount) {
      allocCount += 10;
      coords = realloc(coords, allocCount * sizeof(CLLocationCoordinate2D));
    }
  }
  
  *outputLength = coordIdx;
  return coords;
}


+ (NSString*)encodePolylineForCoordinates:(CLLocationCoordinate2D*)coordinates length:(NSUInteger)inputLength {
  NSMutableString *output = [[NSMutableString alloc] initWithCapacity:inputLength * 4];
  
  int lastIntLatitude = 0;
  int lastIntLongitude = 0;
  for(NSUInteger i = 0; i < inputLength; i++) {
    int intLatitude = (int)round(coordinates[i].latitude / precision);
    int intLongitude = (int)round(coordinates[i].longitude / precision);
    
    int latDifference = intLatitude - lastIntLatitude;
    int lonDifference = intLongitude - lastIntLongitude;
    [output appendString:[self encodeCoordinate:latDifference lon:lonDifference]];
    lastIntLatitude = intLatitude;
    lastIntLongitude = intLongitude;
  }
  
  return output;
}


+ (NSString*)encodeCoordinate:(int)lat lon:(int)lon {
  return [[TBMapzenRoutingPolylineUtils encodeValue:lat]
          stringByAppendingString:[TBMapzenRoutingPolylineUtils encodeValue:lon]];
}


+ (NSString*)encodeValue:(int)coordinate {
  coordinate = (coordinate < 0) ? ~(coordinate<<1) : (coordinate <<1);;
  NSMutableString *returnString = [NSMutableString string];
  do {
    int fiveBitComponent = coordinate & 0x1F;
    if(coordinate >= 0x20){
      fiveBitComponent |= 0x20;
    }
    fiveBitComponent += 63;
    [returnString appendFormat:@"%c", fiveBitComponent];
    coordinate = coordinate >> 5;
  } while (coordinate != 0);
  return returnString;
}

@end
