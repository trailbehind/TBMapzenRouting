//
//  TBMapzenRoutingPoint.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>
#import "TBMapzenRoutingTypes.h"

@interface TBMapzenRoutingPoint : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) TBMapzenRoutingPointType type;
@property (nonatomic, strong, nullable) NSNumber *heading;

+ (instancetype _Nonnull)pointWithCoordinate:(CLLocationCoordinate2D)coordinate type:(TBMapzenRoutingPointType)type;
- (NSDictionary * _Nonnull)asDictionary;

@end
