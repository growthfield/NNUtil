#import "Kiwi.h"
#import "NNEventEmitter.h"

SPEC_BEGIN(NSEventEmitterSpec)

describe(@"NNEventEmitter", ^{

    context(@"event", ^{
        
        it(@"should be emitted without event arg", ^{
            __block NSNumber* isCallbacked = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"hoge" callback:^(NNEvent* event){
                [event shouldBeNil];
                isCallbacked = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"hoge"];
            [[theObject(&isCallbacked) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
        
        it(@"should be emitted with event arg", ^{
            __block NSNumber* isCallbacked = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" callback:^(NNEvent* event){
                [event shouldNotBeNil];
                [[[event value:0] should] equal:@"v1"];
                isCallbacked = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"fuga" event:[NNEvent event:@"v1", nil]];
            [[theObject(&isCallbacked) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });

        it(@"should be emitted twice", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" callback:^(NNEvent* event){
                [event shouldNotBeNil];
                count = [NSNumber numberWithInt:[count intValue] + [[event value:0] intValue]];
            }];
            [em emit:@"fuga" event:[NNEvent event:[NSNumber numberWithInt:1], nil]];
            [em emit:@"fuga" event:[NNEvent event:[NSNumber numberWithInt:2], nil]];
            [[theObject(&count) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:[NSNumber numberWithInt:3]];
        });
        
        it(@"should not be emitted twice", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em once:@"fuga" callback:^(NNEvent* event){
                [event shouldNotBeNil];
                count = [NSNumber numberWithInt:[count intValue] + [[event value:0] intValue]];
            }];
            [em emit:@"fuga" event:[NNEvent event:[NSNumber numberWithInt:1], nil]];
            [em emit:@"fuga" event:[NNEvent event:[NSNumber numberWithInt:2], nil]];
            [[theObject(&count) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:[NSNumber numberWithInt:1]];
        });
        
    });
    
});

SPEC_END
