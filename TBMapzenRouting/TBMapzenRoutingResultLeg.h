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

/** Estimated elapsed time to complete the leg. */
@property (nonatomic, assign) CGFloat length;

/**  Distance traveled for the leg. Units are either miles or kilometers based on the input units specified. */
@property (nonatomic, assign) CGFloat time;

/** The maneuvers the make up the leg. */
@property (nonatomic, readonly, nonnull) NSArray <TBMapzenRoutingResultManeuver*>* maneuvers;

/** The number of coordinates in the trip path. */
@property (nonatomic, readonly) NSUInteger coordinateCount;

/** An array of coordinates representing the geometry of the leg path.
 
 This array is owned by the leg, and will be free()'ed when the the leg is dealloc'ed. If you need to keep this array around past the life of this object, copy it to a new array owned by another object.
 */
@property (nonatomic, readonly, nullable) CLLocationCoordinate2D *coordinates;

/** Create a leg object by parsing an element of the leg array of the server json response. */
+ (instancetype _Nullable)legFromDictionary:(NSDictionary * _Nonnull)response;

@end
