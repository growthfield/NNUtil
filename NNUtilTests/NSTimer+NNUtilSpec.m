#import "Kiwi.h"
#import "NSTimer+NNUtil.h"

SPEC_BEGIN(NSTimerNNUtilSpec)

describe(@"NSTimer+NNUtil", ^{
    
    context(@"block", ^{
        it(@"should be executed only once", ^{
            __block NSNumber* isExecuted = [NSNumber numberWithBool:NO];
            NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
                isExecuted = [NSNumber numberWithBool:YES];
                return NNTimerBlockFinish; 
            }];
            [[theObject(&isExecuted) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
            [[theValue([timer isValid]) should] equal:theValue(NO)];
        });
        it(@"should be executed twice", ^{
            __block NSNumber* count = [NSNumber numberWithInteger:0];
            __block NSNumber* isExecuted = [NSNumber numberWithBool:NO];
            NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
                count = [NSNumber numberWithInteger:count.integerValue + 1];                
                if (count.integerValue >= 2) {
                    isExecuted = [NSNumber numberWithBool:YES];
                    return NNTimerBlockFinish;                     
                } else {
                    return NNTimerBlockCotinue;
                }
            }];
            [[theObject(&isExecuted) shouldEventuallyBeforeTimingOutAfter(5.0)] beYes];
            [[theValue(count.integerValue) should] equal:theValue(2)];
            [[theValue([timer isValid]) should] equal:theValue(NO)];
        });
    });
    
    context(@"interval", ^{
        it(@"should be able to adjust", ^{
            __block NSNumber* count = [NSNumber numberWithInteger:0];
            __block NSNumber* isExecuted = [NSNumber numberWithBool:NO];
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
                count = [NSNumber numberWithInteger:count.integerValue + 1];                
                if (count.integerValue >= 3) {
                    isExecuted = [NSNumber numberWithBool:YES];
                    return NNTimerBlockFinish;                     
                } else {
                    return count.integerValue * 2;
                }
            }];
            [[theObject(&isExecuted) shouldEventuallyBeforeTimingOutAfter(10.0)] beYes];
            [[theValue(count.integerValue) should] equal:theValue(3)];
            [[theValue([timer isValid]) should] equal:theValue(NO)];
        });
    });
    
});


SPEC_END
