#import <Foundation/Foundation.h>
#import "NNReachability.h"

@interface NNReachability()
@property(nonatomic, assign)SCNetworkReachabilityRef reachabilityRef;
@property(nonatomic, assign)SCNetworkReachabilityFlags reachabilityFlags;
@end

@implementation NNReachability
@synthesize reachabilityRef = reachabilityRef_;
@synthesize reachabilityFlags = reachabilityFlags_;
static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    NNReachability* obj = (NNReachability*)info;
    obj.reachabilityFlags = flags;
    [[NSNotificationCenter defaultCenter] postNotificationName:NNREACHABILITY_CHANGED_NOTIFICATION object:obj];
}
+ (NNReachability*)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:&zeroAddress];
}
+ (NNReachability*)reachabilityWithAddress:(const struct sockaddr_in*)address
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)address);
    NNReachability* obj = nil;
    if (reachability) {
        obj = [[[self alloc] init] autorelease];
        if (obj) {
            obj.reachabilityRef = reachability;
        }
    }
    return obj;
}
- (void)dealloc
{
    if (reachabilityRef_) {
        CFRelease(reachabilityRef_);
    }
    [super dealloc];
}
- (BOOL)start
{
    BOOL result = NO;
    SCNetworkReachabilityContext ctx = {0, self, NULL, NULL, NULL};
    if(SCNetworkReachabilitySetCallback(reachabilityRef_, ReachabilityCallback, &ctx)) {
        if(SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef_, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)) {
            result = YES;
        }
    }
    return result;
}
- (void)stop
{
    if (reachabilityRef_) {
        SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef_, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}
- (BOOL)isNetworkAvailable
{
    return (self.reachabilityFlags & kSCNetworkFlagsReachable) && !(self.reachabilityFlags & kSCNetworkFlagsConnectionRequired);
}
- (BOOL)isWifiUsed
{
    return [self isNetworkAvailable] && !(self.reachabilityFlags & kSCNetworkReachabilityFlagsIsWWAN);
}
@end
