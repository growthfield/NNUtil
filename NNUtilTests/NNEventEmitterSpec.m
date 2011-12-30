#import "Kiwi.h"
#import "NNEventEmitter.h"

SPEC_BEGIN(NSEventEmitterSpec)

describe(@"NNEventEmitter", ^{

    context(@"event", ^{
        
        it(@"should be emitted without event arg", ^{
            __block NSNumber* isEmitted = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"hoge" listener:^(NNEvent* event){
                [event shouldBeNil];
                isEmitted = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"hoge"];
            [[theObject(&isEmitted) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
        
        it(@"should be emitted with event arg", ^{
            __block NSNumber* isEmitted = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" listener:^(NNEvent* event){
                [event shouldNotBeNil];
                [[[event value:0] should] equal:@"v1"];
                isEmitted = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"fuga" event:[NNEvent event:@"v1", nil]];
            [[theObject(&isEmitted) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });

        it(@"should be emitted twice", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" listener:^(NNEvent* event){
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
            [em once:@"fuga" listener:^(NNEvent* event){
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
