//
//  TBMapzenRoutingController.m
//  TBMapzenRouting
//
//  Created by Jesse Crocker on 7/19/16.
//
//

#import "TBMapzenRoutingController.h"

@interface TBMapzenRoutingController ()

@property (nonatomic, strong, nonnull) NSURLSession *urlSessionManager;

@end


@implementation TBMapzenRoutingController

- (instancetype _Nonnull)initWithApiKey:(NSString * _Nonnull)apiKey {
  self = [super init];
  self.apiKey = apiKey;
  self.baseUrl = @"https://valhalla.mapzen.com/route?";
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.urlSessionManager = [NSURLSession sessionWithConfiguration:configuration];
  return self;
}


- (id _Nullable)requestRouteWithLocations:(NSArray<TBMapzenRoutingPoint*>* _Nonnull)locations
                             costingModel:(TBMapzenRoutingCostingModel)costing
                            costingOption:(NSDictionary<NSString*, NSObject*>* _Nullable)costingOptions
                        directionsOptions:(NSDictionary<NSString*, NSObject*>* _Nullable)directionsOptions
                                 callback:(void (^ _Nonnull)(TBMapzenRoutingResult  * _Nullable result,
                                                             id _Nullable invalidationToken,
                                                             NSError * _Nullable error ))callback {
  if(locations.count < 2) {
    callback(nil, nil, [NSError errorWithDomain:@"TBMapzenRoutingController"
                                           code:0
                                       userInfo:@{NSLocalizedDescriptionKey: @"Locations array must contain 2 or more locations"}]);
    return nil;
  }
  
  NSMutableDictionary *jsonParameters = [NSMutableDictionary dictionaryWithCapacity:3];
  jsonParameters[@"api_key"] = self.apiKey;
  jsonParameters[@"costing"] = [TBMapzenRoutingTypes stringFromCostingModel:costing];
  jsonParameters[@"locations"] = [TBMapzenRoutingController convertLocationsToDictionarys:locations];
  
  if(costingOptions) {
    if(![NSJSONSerialization isValidJSONObject:costingOptions]) {
      callback(nil, nil, [NSError errorWithDomain:@"TBMapzenRoutingController"
                                             code:0
                                         userInfo:@{NSLocalizedDescriptionKey: @"costingOptions is not a valid json object"}]);
      return nil;
    }
    jsonParameters[@"costing_options"] = costingOptions;
  }
  
  if(directionsOptions) {
    if(![NSJSONSerialization isValidJSONObject:directionsOptions]) {
      callback(nil, nil, [NSError errorWithDomain:@"TBMapzenRoutingController"
                                             code:0
                                         userInfo:@{NSLocalizedDescriptionKey: @"directionsOptions is not a valid json object"}]);
      return nil;
    }
    jsonParameters[@"directions_options"] = directionsOptions;
  }
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonParameters
                                                     options:0
                                                       error:nil];
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self.baseUrl];
  urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey],
                               [NSURLQueryItem queryItemWithName:@"json" value:jsonString]
                               ];
  
  NSURLSessionDataTask *task;
  task =
  [self.urlSessionManager dataTaskWithURL:urlComponents.URL
                        completionHandler:
   ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     if(error || ((NSHTTPURLResponse*)response).statusCode != 200) {
       NSString *responseString;
       if(data) {
         responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       }
       dispatch_async(dispatch_get_main_queue(), ^{
         callback(nil, task, [NSError errorWithDomain:@"TBMapzenRoutingServerResponse"
                                                 code:((NSHTTPURLResponse*)response).statusCode
                                             userInfo:@{NSLocalizedDescriptionKey:responseString ?: @"unknown error"}]);
       });
     } else {
       NSError *error;
       NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:&error];
       if(error) {
         dispatch_async(dispatch_get_main_queue(), ^{
           callback(nil, nil, [NSError errorWithDomain:@"TBMapzenRoutingServerResponse"
                                                  code:0
                                              userInfo:@{NSLocalizedDescriptionKey: @"response is not a valid json object"}]);
         });
       } else {
         TBMapzenRoutingResult *result = [TBMapzenRoutingController parseServerResponse:responseDictionary
                                                                                   task:task
                                                                                  error:&error];
         dispatch_async(dispatch_get_main_queue(), ^{
           callback(result, task, error);
         });
       }
     }
   }];
  [task resume];
  return task;
}


- (void)cancelRoutingRequest:(id)requestToken {
  if([requestToken isKindOfClass:[NSURLSessionDataTask class]]) {
    [(NSURLSessionDataTask*)requestToken cancel];
  }
}


+ (TBMapzenRoutingResult* _Nullable)parseServerResponse:(NSDictionary * _Nonnull)response
                                                   task:(NSURLSessionDataTask * _Nonnull)task
                                                  error:(NSError * _Nullable *)error {
  TBMapzenRoutingResult *result = [TBMapzenRoutingResult resultFromResponse:response];
  return result;
}


+ (NSArray <NSDictionary*> *)convertLocationsToDictionarys:(NSArray<TBMapzenRoutingPoint*>* _Nonnull)locations {
  NSMutableArray *output = [NSMutableArray arrayWithCapacity:locations.count];
  for(TBMapzenRoutingPoint *point in locations) {
    [output addObject:[point asDictionary]];
  }
  return output;
}


@end
