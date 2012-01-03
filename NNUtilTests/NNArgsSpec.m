#import "Kiwi.h"
#import "NNArgs.h"

SPEC_BEGIN(NSArgsSpec)

describe(@"NNArgs", ^{
    
    context(@"empty args", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            args = [NNArgs args];
        });
        it(@"value0 should be nil", ^{
            [[args get:0] shouldBeNil];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"count should be 0", ^{
            [[theValue(args.count) should] equal:theValue(0)];                        
        });
        it(@"values should have 0 object", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(0)];            
        });
    });
    
    context(@"args added 1 non-nil value", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            args = [[NNArgs args] add:@"v1"];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldNotBeNil];
            [[[args get:0] should] equal:@"v1"];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"values should have 1 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(1)];
        });
    });
    
    context(@"args added array which has 1 non-nil value", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            NSArray* array = [NSArray arrayWithObject:@"v1"];
            args = [[NNArgs args] addAll:array];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldNotBeNil];
            [[[args get:0] should] equal:@"v1"];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"values should have 1 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(1)];
        });
    });

    context(@"args appended 1 nil value", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            args = [[NNArgs args] add:nil];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldBeNil];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"values should have 1 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(1)];
            [[[values objectAtIndex:0] should] equal:[NSNull null]];
        });
    });
    
    context(@"args appended array which has 1 NSNull", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            NSArray* array = [NSArray arrayWithObject:[NSNull null]];
            args = [[NNArgs args] addAll:array];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldBeNil];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"values should have 1 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(1)];
            [[[values objectAtIndex:0] should] equal:[NSNull null]];
        });
    });    
    
    context(@"args added 2 non-nil values", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            args = [[[NNArgs args] add:@"v1"] add:@"v2"];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldNotBeNil];
            [[[args get:0] should] equal:@"v1"];
        });
        it(@"value1 should not be nil", ^{
            [[args get:1] shouldNotBeNil];
            [[[args get:1] should] equal:@"v2"];
        });
        it(@"value2 should be nil", ^{
            [[args get:2] shouldBeNil];
        });
        it(@"values should have 2 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(2)];
        });
    });
    
    context(@"args added array which has 2 non-nil values", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            NSArray* array = [NSArray arrayWithObjects:@"v1", @"v2", nil];
            args = [[NNArgs args] addAll:array];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldNotBeNil];
            [[[args get:0] should] equal:@"v1"];
        });
        it(@"value1 should not be nil", ^{
            [[args get:1] shouldNotBeNil];
            [[[args get:1] should] equal:@"v2"];
        });
        it(@"value2 should be nil", ^{
            [[args get:2] shouldBeNil];
        });
        it(@"values should have 2 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(2)];
        });
    });
    
    context(@"args added nil mixed value", ^{
        __block NNArgs* args = nil;
        beforeEach(^{
            args = [[[NNArgs args] add:@"v1"] add:nil];
        });
        it(@"value0 should not be nil", ^{
            [[args get:0] shouldNotBeNil];
            [[[args get:0] should] equal:@"v1"];
        });
        it(@"value1 should be nil", ^{
            [[args get:1] shouldBeNil];
        });
        it(@"value2 should be nil", ^{
            [[args get:2] shouldBeNil];
        });
        it(@"values should have 2 value", ^{
            NSArray* values = args.array;
            [values shouldNotBeNil];
            [[theValue(values.count) should] equal:theValue(2)];
        });
    });

    
});

SPEC_END
