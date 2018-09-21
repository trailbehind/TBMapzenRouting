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

/** URL for routing server. Defaults to URL for Mapzen Turn-by-Turn production server. */
@property (nonatomic, strong, nonnull) NSString *baseUrl;

/** Mapzen Turn-by-Turn api key. */
@property (nonatomic, strong, nonnull) NSString *apiKey;

/**
 Create a new routing controller configured to connect to the Mapzen Turn-by-Turn production server.
 
 @param apiKey API to be used for routing requests.
 */
- (instancetype _Nonnull)initWithApiKey:(NSString * _Nonnull)apiKey;

/**
 Request a route.
 
 @param locations Locations to route to/thru
 @param costing Costing mode
 @param costingOptions costing options
 @param directionsOptions options for directions output
 @param callback Callback function. 

 @return an opaque object that can be used to cancel the routing request before it has completed.
 */
- (id _Nullable)requestRouteWithLocations:(NSArray<TBMapzenRoutingPoint*>* _Nonnull)locations
                     costingModel:(TBMapzenRoutingCostingModel)costing
                    costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                         callback:(void (^ _Nonnull)(TBMapzenRoutingResult  * _Nullable result,
                                                     id _Nullable invalidationToken,
                                                     NSError * _Nullable error ))callback;

/**
 Request a map match.
 
 @param locations Locations to route to/thru
 @param number of locations
 @param costing Costing mode
 @param callback Callback function.

@return an opaque object that can be used to cancel the routing request before it has completed.
*/
- (id _Nullable)requestMapMatchWithLocations:(CLLocationCoordinate2D* _Nonnull)locations
                                       count:(NSUInteger)coordinateCount
                                costingModel:(TBMapzenRoutingCostingModel)costing
                                 callback:(void (^ _Nonnull)(TBMapzenRoutingResult  * _Nullable result,
                                                             id _Nullable invalidationToken,
                                                             NSError * _Nullable error ))callback;

/**
 Request raw json response for map match.
 
 @param locations Locations to route to/thru
 @param number of locations
 @param costing Costing mode
 @param callback Callback function.
 
 @return an opaque object that can be used to cancel the routing request before it has completed.
 */
- (id _Nullable)requestMapMatchJsonWithLocations:(CLLocationCoordinate2D* _Nonnull)locations
                                           count:(NSUInteger)coordinateCount
                                    costingModel:(TBMapzenRoutingCostingModel)costing
                                        callback:(void (^ _Nonnull)(NSData  * _Nullable resultData,
                                                                    id _Nullable invalidationToken,
                                                                    NSError * _Nullable error ))callback;

/** Cancel an in-progress routing request. Cancelation is not guaranteed to succeed.
 
 @param requestToken an object returned by requestRouteWithLocations:costingModel:costingOption:directionsOptions:callback
 */
- (void)cancelRoutingRequest:(id _Nonnull)requestToken;



@end
