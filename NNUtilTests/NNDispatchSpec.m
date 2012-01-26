#import "Kiwi.h"
#import "NNDispatch.h"

SPEC_BEGIN(NNDispatchSpec)
describe(@"NNDispatch", ^{
    
    NSNumber* Yes = [NSNumber numberWithBool:YES];
    NSNumber* No = [NSNumber numberWithBool:NO];
    
    context(@"dispatch after", ^{
        it(@"should be invoked after delay", ^{
            dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
            __block NSNumber* invoked = No; 
            NNDispatch* dispatch = [NNDispatch dispatchAfter:delay queue:dispatch_get_main_queue() block:^{
                invoked = Yes;
            }];                
            [dispatch shouldNotBeNil];
            [[theObject(&invoked) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
    });
});
SPEC_END

