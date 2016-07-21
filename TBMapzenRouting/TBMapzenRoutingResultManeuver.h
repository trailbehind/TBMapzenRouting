//
//  TBMapzenRoutingResultManeuver.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>

@interface TBMapzenRoutingResultManeuver : NSObject

+ (instancetype _Nullable)maneuverFromDictionary:(NSDictionary * _Nonnull)response;
@property (nonatomic, strong, nonnull) NSDictionary *data;
//TODO: add maneuver fields

@end
