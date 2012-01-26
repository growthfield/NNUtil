#import <Foundation/Foundation.h>

@interface NNDispatch : NSObject
{
    @private
    BOOL cancled_;
    BOOL finished_;
}
@property(nonatomic, assign, readonly) BOOL finished;
+ (NNDispatch*)dispatchAfter:(dispatch_time_t)delay queue:(dispatch_queue_t)queue block:(dispatch_block_t)block;
- (void)cancel;
@end
