//
//  TBMapzenRoutingResultLeg.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import "TBMapzenRoutingResultManeuver.h"

@interface TBMapzenRoutingResultLeg : NSObject

@property (nonatomic, assign) CGFloat length;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, readonly, nonnull) NSArray <TBMapzenRoutingResultManeuver*>* maneuvers;
@property (nonatomic, readonly) NSUInteger coordinateCount;
@property (nonatomic, readonly, nullable) CLLocationCoordinate2D *coordinates;

+ (instancetype _Nullable)legFromDictionary:(NSDictionary * _Nonnull)response;

@end
