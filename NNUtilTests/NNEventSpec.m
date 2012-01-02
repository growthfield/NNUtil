#import "Kiwi.h"
#import "NNEvent.h"

SPEC_BEGIN(NSEventSpec)

describe(@"NNEvent", ^{
    context(@"event which has no values", ^{
        __block NNEvent* event = nil;
        beforeEach(^{
            event = [NNEvent event];
        });
        it(@"value0 should be nil", ^{
            [[event value:0] shouldBeNil];
        });
        it(@"value1 should be nil", ^{
            [[event value:1] shouldBeNil];
        });
        it(@"values should be nil", ^{
            NSArray* values = [event values];
            [values shouldBeNil];
        });
    });
    context(@"event which has 1 value", ^{
        __block NNEvent* event = nil;
        beforeEach(^{
            event = [NNEvent event:@"v1", nil];
        });
        it(@"value0 should not be nil", ^{
            [[event value:0] shouldNotBeNil];
            [[[event value:0] should] equal:@"v1"];
        });
        it(@"value1 should be nil", ^{
            [[event value:1] shouldBeNil];
        });
        it(@"values should have 1 value", ^{
            NSArray* values = [event values];
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(1)];
        });
    });
    context(@"event which has 2 values", ^{
        __block NNEvent* event = nil;
        beforeEach(^{
            event = [NNEvent event:@"v1", @"v2", nil];
        });
        it(@"value0 should not be nil", ^{
            [[event value:0] shouldNotBeNil];
            [[[event value:0] should] equal:@"v1"];
        });
        it(@"value1 should not be nil", ^{
            [[event value:1] shouldNotBeNil];
            [[[event value:1] should] equal:@"v2"];
        });
        it(@"value2 should be nil", ^{
            [[event value:2] shouldBeNil];
        });
        it(@"values should have 2 value", ^{
            NSArray* values = [event values];
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(2)];
        });

    });
    
    context(@"event which has NSNull value", ^{
        __block NNEvent* event = nil;
        beforeEach(^{
            event = [NNEvent event:[NSNull null], [NSNull null], @"v3", nil];
        });
        it(@"value0 should be nil", ^{
            [[event value:0] shouldBeNil];
        });
        it(@"value1 should be nil", ^{
            [[event value:1] shouldBeNil];
        });
        it(@"value2 should not be nil", ^{
            [[event value:2] shouldNotBeNil];
            [[[event value:2] should] equal:@"v3"];
        });
        it(@"values should have 3 value", ^{
            NSArray* values = [event values];
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(3)];
        });
    });
});

SPEC_END
