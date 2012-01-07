#import "Kiwi.h"
#import "NNEventEmitter.h"

SPEC_BEGIN(NSEventEmitterSpec)

describe(@"NNEventEmitter", ^{
    
    context(@"event", ^{
        it(@"should be emitted without event arg", ^{
            __block NSNumber* isEmitted = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"hoge" listener:^(NNArgs* args){
                [args shouldBeNil];
                isEmitted = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"hoge"];
            [[theObject(&isEmitted) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
        it(@"should be emitted with event arg", ^{
            __block NSNumber* isEmitted = [NSNumber numberWithBool:NO];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" listener:^(NNArgs* args){
                [args shouldNotBeNil];
                [[[args get:0] should] equal:@"v1"];
                isEmitted = [NSNumber numberWithBool:YES];
            }];
            [em emit:@"fuga" args:[[NNArgs args] add:@"v1"]];
            [[theObject(&isEmitted) shouldEventuallyBeforeTimingOutAfter(3.0)] beYes];
        });
        it(@"should be emitted twice", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em on:@"fuga" listener:^(NNArgs* args){
                [args shouldNotBeNil];
                count = [NSNumber numberWithInt:[count intValue] + [[args get:0] intValue]];
            }];
            [em emit:@"fuga" args:[[NNArgs args] add:[NSNumber numberWithInt:1]]];
            [em emit:@"fuga" args:[[NNArgs args] add:[NSNumber numberWithInt:2]]];
            [[theObject(&count) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:[NSNumber numberWithInt:3]];
        });
        it(@"should not be emitted twice", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            [em once:@"fuga" listener:^(NNArgs* args){
                [args shouldNotBeNil];
                count = [NSNumber numberWithInt:[count intValue] + [[args get:0] intValue]];
            }];
            [em emit:@"fuga" args:[[NNArgs args] add:[NSNumber numberWithInt:1]]];
            [em emit:@"fuga" args:[[NNArgs args] add:[NSNumber numberWithInt:2]]];
            [[theObject(&count) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:[NSNumber numberWithInt:1]];
        });
    });
    
    context(@"listener", ^{
        it(@"should be registered duplicately", ^{
            __block NSNumber* count = [NSNumber numberWithInt:0];                
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            NNEventListener listener = ^(NNArgs* args) {
                count = [NSNumber numberWithInt:[count intValue] + 1];
            };
            [em on:@"hoge" listener:listener];
            [em on:@"hoge" listener:listener];
            [em emit:@"hoge" args:nil];
            [[theObject(&count) shouldEventuallyBeforeTimingOutAfter(3.0)] equal:[NSNumber numberWithInt:2]];            
        });
        
        it(@"should be removed", ^{
            NNEventEmitter* em = [[[NNEventEmitter alloc] init] autorelease];
            NNEventListener listener = ^(NNArgs* args) {};
            id blk = [[listener copy] autorelease];
            [em on:@"hoge" listener:blk];
            [[theValue([em listeners:@"hoge"].count) should] equal:theValue(1)];
            [em removeLisitener:@"hoge" listener:blk];
            [[theValue([em listeners:@"hoge"].count) should] equal:theValue(0)];            
        });
    });
});

SPEC_END
