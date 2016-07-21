//
//  TBMapzenRoutingController.h
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import <Foundation/Foundation.h>
#import "TBMapzenRoutingResult.h"
#import "TBMapzenRoutingTypes.h"
#import "TBMapzenRoutingPoint.h"

@interface TBMapzenRoutingController : NSObject

@property (nonatomic, strong, nonnull) NSString *baseUrl;
@property (nonatomic, strong, nonnull) NSString *apiKey;

- (instancetype _Nonnull)initWithApiKey:(NSString * _Nonnull)apiKey;

- (id _Nullable)requestRouteWithLocations:(NSArray<TBMapzenRoutingPoint*>* _Nonnull)locations
                     costingModel:(TBMapzenRoutingCostingModel)costing
                    costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                         callback:(void (^ _Nonnull)(TBMapzenRoutingResult  * _Nullable result,
                                                     id _Nullable invalidationToken,
                                                     NSError * _Nullable error ))callback;

- (void)cancelRoutingRequest:(id _Nonnull)requestToken;

@end
