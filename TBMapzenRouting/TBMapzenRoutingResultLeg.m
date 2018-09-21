//
//  TBMapzenRoutingResultLeg.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TBMapzenRoutingResultLeg.h"
#import "TBMapzenRoutingPolylineUtils.h"

@interface TBMapzenRoutingResultLeg ()

@property (nonatomic, strong, nonnull) NSArray <TBMapzenRoutingResultManeuver*>* maneuvers;
@property (nonatomic, assign) NSUInteger coordinateCount;
@property (nonatomic, assign, nullable) CLLocationCoordinate2D *coordinates;

@end


@implementation TBMapzenRoutingResultLeg


+ (instancetype _Nullable)legFromDictionary:(NSDictionary * _Nonnull)response {
  TBMapzenRoutingResultLeg *leg = [[TBMapzenRoutingResultLeg alloc] init];
  leg.length = [response[@"summary"][@"length"] doubleValue];
  leg.time = [response[@"summary"][@"time"] doubleValue];
  NSMutableArray *maneuvers = [NSMutableArray arrayWithCapacity:[(NSArray*)response[@"maneuvers"] count]];
  for(NSDictionary *maneuver in response[@"maneuvers"]) {
    [maneuvers addObject:[TBMapzenRoutingResultManeuver maneuverFromDictionary:maneuver]];
  }
  leg.maneuvers = maneuvers;
  leg.coordinates = [TBMapzenRoutingPolylineUtils decodePolyline:response[@"shape"]
                                             length:&leg->_coordinateCount];
  
  return leg;
}


- (NSString * _Nonnull)description {
  return [NSString stringWithFormat:@"<%@: %p> length:%f time:%f maneuvers:%lu coordinates:%lu",
          NSStringFromClass([self class]), self,
          self.length, self.time,
          (unsigned long)self.maneuvers.count, (unsigned long)self.coordinateCount];
}


- (void)dealloc {
  free(self.coordinates);
}


@end
