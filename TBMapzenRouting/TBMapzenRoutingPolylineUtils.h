//
//  TBMapzenRoutingPolylineUtils.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 9/17/18.
//  Copyright © 2018 Trailbehind inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBMapzenRoutingPolylineUtils : NSObject

+ (CLLocationCoordinate2D*)decodePolyline:(NSString*)polyline length:(NSUInteger*)outputLength;
+ (NSString*)encodePolylineForCoordinates:(CLLocationCoordinate2D*)coordinates length:(NSUInteger)inputLength;

@end

NS_ASSUME_NONNULL_END
