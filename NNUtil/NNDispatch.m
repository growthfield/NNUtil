#import "NNDispatch.h"

@implementation NNDispatch
@synthesize finished = finished_;
+ (NNDispatch*)dispatchAfter:(dispatch_time_t)delay queue:(dispatch_queue_t)queue block:(dispatch_block_t)block
{
    NNDispatch* dispatch = [[[self alloc] init] autorelease];
    dispatch_after(delay, queue, ^{
        if(!dispatch->cancled_) {
            block();
        }
        dispatch->finished_ = YES;
    });
    return dispatch;
}
- (id)init
{
    self = [super init];
    if (self) {
        cancled_ = NO;
    }
    return self;
}
- (void)cancel
{
    cancled_ = YES;
}
@end
