#import "Kiwi.h"
#import "NSString+Trimming.h"

SPEC_BEGIN(NSStringTrimmingSpec)

describe(@"trimming", ^{

    __block NSString* string = nil;

    context(@"empty string", ^{
        beforeEach(^{
            string = @"";
        });
        context(@"trim left", ^{
            it(@"should do nothing", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
        context(@"trim right", ^{
            it(@"should do nothing", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
    });

    context(@"string which only consists of trimmable chars", ^{
        beforeEach(^{
            string = @"   ";
        });
        context(@"trim left", ^{
            it(@"should be empty", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@""];
            });
        });
        context(@"trim right", ^{
            it(@"should be empty", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@""];
            });
        });
    });

    context(@"string which contains trimmable chars at the left end", ^{
        beforeEach(^{
            string = @"  abc";
        });
        context(@"trim left", ^{
            it(@"should be trimed at the left end", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"abc"];
            });
        });
        context(@"trim right", ^{
            it (@"should do nothing", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
    });

    context(@"string which contains trimmable chars at the right end", ^{
        beforeEach(^{
            string = @"abc  ";
        });
        context(@"trim left", ^{
            it(@"should do nothing", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
        context(@"trim right", ^{
            it(@"should be trimed at the right end", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"abc"];
            });
        });
    });

    context(@"string which contains trimmable chars at the both end", ^{
        beforeEach(^{
            string = @"  abc ";
        });
        context(@"trim left", ^{
            it(@"should be trimed at the only left end", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"abc "];
            });
        });
        context(@"trim right", ^{
            it (@"should be trimed at the only right end", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"  abc"];
            });
        });
    });

    context(@"string which contains trimmable chars at the middle", ^{
        beforeEach(^{
            string = @"a  b  c";
        });
        context(@"trim left", ^{
            it(@"should do nothing", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
        context(@"trim right", ^{
            it(@"should do nothing", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:string];
            });
        });
    });

    context(@"string which contains trimmable chars at the both end and middle", ^{
        beforeEach(^{
            string = @"  a b c ";
        });
        context(@"trim left", ^{
            it(@"should be trimed at the only left end", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"a b c "];
            });
        });
        context(@"trim right", ^{
            it (@"should be trimed at the only right end", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"  a b c"];
            });
        });
    });

    context(@"multibyte string which contains trimmable chars at the both end and middle", ^{
        beforeEach(^{
            string = @"  あ い う ";
        });
        context(@"trim left", ^{
            it(@"should be trimed at the only left end", ^{
                [[[string stringByLeftTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"あ い う "];
            });
        });
        context(@"trim right", ^{
            it (@"should be trimed at the only right end", ^{
                [[[string stringByRightTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] should] equal:@"  あ い う"];
            });
        });
    });


});

SPEC_END
