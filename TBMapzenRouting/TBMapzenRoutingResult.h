//
//  TBMapzenRoutingResult.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>
#import "TBMapzenRoutingResultLeg.h"


@interface TBMapzenRoutingResult : NSObject

@property (nonatomic, assign) CGFloat length;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, strong, nullable) NSString *units;
@property (nonatomic, strong, nonnull) NSArray<TBMapzenRoutingResultLeg *> * legs;

+ (instancetype _Nullable)resultFromResponse:(NSDictionary * _Nonnull)response;

@end
