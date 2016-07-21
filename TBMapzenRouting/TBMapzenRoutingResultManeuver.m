//
//  TBMapzenRoutingResultManeuver.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import "TBMapzenRoutingResultManeuver.h"

@implementation TBMapzenRoutingResultManeuver

+ (instancetype _Nullable)maneuverFromDictionary:(NSDictionary * _Nonnull)response {
  TBMapzenRoutingResultManeuver *maneuver = [[TBMapzenRoutingResultManeuver alloc] init];
  maneuver.data = response;
  //TODO: decode maneuver
  return maneuver;
}

@end
