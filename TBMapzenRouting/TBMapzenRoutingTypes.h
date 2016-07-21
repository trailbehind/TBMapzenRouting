//
//  TBMapzenRoutingTypes.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TBMapzenRoutingPointType) {
  TBMapzenRoutingPointTypeBreak,
  TBMapzenRoutingPointTypeThrough
};

typedef NS_ENUM(NSUInteger, TBMapzenRoutingCostingModel) {
  TBMapzenRoutingCostingModelAuto,
  TBMapzenRoutingCostingModelAutoShorter,
  TBMapzenRoutingCostingModelBicycle,
  TBMapzenRoutingCostingModelBus,
  TBMapzenRoutingCostingModelMultimodal,
  TBMapzenRoutingCostingModelPedestrian
};

@interface TBMapzenRoutingTypes : NSObject

+ (NSString * _Nonnull)stringFromCostingModel:(TBMapzenRoutingCostingModel)costing;
+ (NSString * _Nonnull)stringFromRoutingPointType:(TBMapzenRoutingPointType)type;

@end
