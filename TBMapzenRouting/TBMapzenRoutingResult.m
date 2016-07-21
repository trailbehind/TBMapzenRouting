//
//  TBMapzenRoutingResult.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import "TBMapzenRoutingResult.h"

@implementation TBMapzenRoutingResult

+ (instancetype _Nullable)resultFromResponse:(NSDictionary * _Nonnull)response {
  TBMapzenRoutingResult *result = [[TBMapzenRoutingResult alloc] init];
  NSDictionary *trip = response[@"trip"];
  result.length = [trip[@"summary"][@"length"] doubleValue];
  result.time = [trip[@"summary"][@"time"] doubleValue];
  result.units = trip[@"units"];
  
  NSMutableArray <TBMapzenRoutingResultLeg *> *legs = [NSMutableArray arrayWithCapacity:[(NSArray*)trip[@"legs"] count]];
  for(NSDictionary *leg in trip[@"legs"]) {
    [legs addObject:[TBMapzenRoutingResultLeg legFromDictionary:leg]];
  }
  result.legs = legs;
  return result;
}


@end
