#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

#define NNREACHABILITY_CHANGED_NOTIFICATION @"NNReachabilityChangedNotification"

@interface NNReachability : NSObject
{
    @private
    SCNetworkReachabilityRef reachabilityRef_;
    SCNetworkReachabilityFlags reachabilityFlags_;
}
@property(nonatomic, readonly, getter=isNetworkAvailable) BOOL isNetworkAvailable;
@property(nonatomic, readonly, getter=isWifiUsed) BOOL isWifiUsed;
+ (NNReachability*)reachabilityForInternetConnection;
+ (NNReachability*)reachabilityWithAddress:(const struct sockaddr_in*)address;
- (BOOL)start;
- (void)stop;
- (BOOL)isNetworkAvailable;
- (BOOL)isWifiUsed;
@end
