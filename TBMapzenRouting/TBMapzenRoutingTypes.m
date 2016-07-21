//
//  TBMapzenRoutingTypes.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import "TBMapzenRoutingTypes.h"

@implementation TBMapzenRoutingTypes

+ (NSString* _Nonnull)stringFromCostingModel:(TBMapzenRoutingCostingModel)costing {
  switch (costing) {
    case TBMapzenRoutingCostingModelAuto:
      return @"auto";
    case TBMapzenRoutingCostingModelAutoShorter:
      return @"auto_shorter";
    case TBMapzenRoutingCostingModelBicycle:
      return @"bicycle";
    case TBMapzenRoutingCostingModelBus:
      return @"bus";
    case TBMapzenRoutingCostingModelMultimodal:
      return @"multimodal";
    case TBMapzenRoutingCostingModelPedestrian:
      return @"pedestrian";
  }
}


+ (NSString * _Nonnull)stringFromRoutingPointType:(TBMapzenRoutingPointType)type {
  switch (type) {
    case TBMapzenRoutingPointTypeBreak:
      return @"break";
    case TBMapzenRoutingPointTypeThrough:
      return @"through";
  }
}

@end
