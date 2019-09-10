//
//  TBMapzenRoutingResultManeuver.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import "TBMapzenRoutingResultManeuver.h"

@implementation TBMapzenRoutingResultManeuver

+ (instancetype)maneuverFromDictionary:(NSDictionary * _Nonnull)response {
  TBMapzenRoutingResultManeuver *maneuver = [[TBMapzenRoutingResultManeuver alloc] init];
  
  maneuver.type = [response[@"type"] unsignedLongValue];
  maneuver.instruction = response[@"instruction"];
  maneuver.verbalTransitionAlertInstruction = response[@"verbal_transition_alert_instruction"];
  maneuver.verbalPreTransitionInstruction = response[@"verbal_pre_transition_instruction"];
  maneuver.verbalPostTransitionInstruction = response[@"verbal_post_transition_instruction"];
  maneuver.streetNames = response[@"street_names"];
  maneuver.beginStreetNames = response[@"begin_street_names"];
  maneuver.time = [response[@"time"] unsignedLongValue];
  maneuver.length = [response[@"length"] doubleValue];
  maneuver.beginShapeIndex = [response[@"begin_shape_index"] unsignedLongValue];
  maneuver.beginRouteIndex = [response[@"begin_route_index"] unsignedLongValue];
  maneuver.beginCoordinate = CLLocationCoordinate2DMake([response[@"begin_coordinate_latitude"] doubleValue], [response[@"begin_coordinate_longitude"] doubleValue]);
  maneuver.endShapeIndex = [response[@"end_shape_index"] unsignedLongValue];
  maneuver.endRouteIndex = [response[@"end_route_index"] unsignedLongValue];
  maneuver.endCoordinate = CLLocationCoordinate2DMake([response[@"end_coordinate_latitude"] doubleValue], [response[@"end_coordinate_longitude"] doubleValue]);
  maneuver.toll = [response[@"toll"] boolValue];
  maneuver.rough = [response[@"rough"] boolValue];
  maneuver.gate = [response[@"gate"] boolValue];
  maneuver.ferry = [response[@"ferry"] boolValue];
  maneuver.sign = response[@"sign"];
  maneuver.roundaboutExitCount = [response[@"roundabout_exit_count"] unsignedLongValue];
  maneuver.departInstruction = response[@"depart_instruction"];
  maneuver.verbalDepartInstruction = response[@"verbal_depart_instruction"];
  maneuver.arriveInstruction = response[@"arrive_instruction"];
  maneuver.verbalArriveInstruction = response[@"verbal_arrive_instruction"];
  maneuver.transitInfo = response[@"transit_info"];
  maneuver.verbalMultiCue = [response[@"verbal_multi_cue"] boolValue];
  maneuver.travelMode = response[@"travel_mode"];
  maneuver.travelType = response[@"travel_type"];
  
  return maneuver;
}

- (NSDictionary *)toDictionary {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  dict[@"type"] = [NSNumber numberWithUnsignedLong:self.type];
  dict[@"instruction"] = self.instruction;
  dict[@"verbal_transition_alert_instruction"] = self.verbalTransitionAlertInstruction;
  dict[@"verbal_pre_transition_instruction"] = self.verbalPreTransitionInstruction;
  dict[@"verbal_post_transition_instruction"] = self.verbalPostTransitionInstruction;
  dict[@"street_names"] = self.streetNames;
  dict[@"begin_street_names"] = self.beginStreetNames;
  dict[@"time"] = [NSNumber numberWithUnsignedLong:self.time];
  dict[@"length"] = [NSNumber numberWithDouble:self.length];
  dict[@"begin_shape_index"] = [NSNumber numberWithUnsignedLong:self.beginShapeIndex];
  dict[@"begin_route_index"] = [NSNumber numberWithUnsignedLong:self.beginRouteIndex];
  dict[@"begin_coordinate_latitude"] = [NSNumber numberWithDouble:self.beginCoordinate.latitude];
  dict[@"begin_coordinate_longitude"] = [NSNumber numberWithDouble:self.beginCoordinate.longitude];
  dict[@"end_shape_index"] = [NSNumber numberWithUnsignedLong:self.endShapeIndex];
  dict[@"end_route_index"] = [NSNumber numberWithUnsignedLong:self.endRouteIndex];
  dict[@"end_coordinate_latitude"] = [NSNumber numberWithDouble:self.endCoordinate.latitude];
  dict[@"end_coordinate_longitude"] = [NSNumber numberWithDouble:self.endCoordinate.longitude];
  dict[@"toll"] = [NSNumber numberWithBool:self.toll];
  dict[@"rough"] = [NSNumber numberWithBool:self.rough];
  dict[@"gate"] = [NSNumber numberWithBool:self.gate];
  dict[@"ferry"] = [NSNumber numberWithBool:self.ferry];
  dict[@"sign"] = self.sign;
  dict[@"roundabout_exit_count"] = [NSNumber numberWithUnsignedLong:self.roundaboutExitCount];
  dict[@"depart_instruction"] = self.departInstruction;
  dict[@"verbal_depart_instruction"] = self.verbalDepartInstruction;
  dict[@"arrive_instruction"] = self.arriveInstruction;
  dict[@"verbal_arrive_instruction"] = self.verbalArriveInstruction;
  dict[@"transit_info"] = self.transitInfo;
  dict[@"verbal_multi_cue"] = [NSNumber numberWithBool:self.verbalMultiCue];
  dict[@"travel_mode"] = self.travelMode;
  dict[@"travel_type"] = self.travelType;
  return dict;
}

@end
