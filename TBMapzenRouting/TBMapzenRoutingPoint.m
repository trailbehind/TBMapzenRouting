//
//  TBMapzenRoutingPoint.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <CoreLocation/CoreLocation.h>
#import "TBMapzenRoutingPoint.h"
#import "TBMapzenRoutingTypes.h"

@implementation TBMapzenRoutingPoint

+ (instancetype _Nonnull)pointWithCoordinate:(CLLocationCoordinate2D)coordinate type:(TBMapzenRoutingPointType)type {
  TBMapzenRoutingPoint *point = [[TBMapzenRoutingPoint alloc] init];
  point.coordinate = coordinate;
  point.type = type;
  return point;
}


- (NSDictionary * _Nonnull)asDictionary {
  NSDictionary *dictionary = @{
                               @"lat": @(self.coordinate.latitude),
                               @"lon": @(self.coordinate.longitude),
                               @"type": [TBMapzenRoutingTypes stringFromRoutingPointType:self.type]
                               };
  if(self.heading) {
    NSMutableDictionary *mutable = [dictionary mutableCopy];
    mutable[@"heading"] = self.heading;
    dictionary = mutable;
  }
  return dictionary;
}

@end
