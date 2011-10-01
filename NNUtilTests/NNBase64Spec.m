#import "Kiwi.h"
#import "NNBase64.h"

SPEC_BEGIN(NNBase64Spec)

describe(@"NNBase64", ^{

    __block NNBase64* base64 = nil;
    
    context(@"base64", ^{
        
        beforeEach(^{
            base64 = [NNBase64 base64]; 
        });
    
        context(@"encode nil data", ^{
            it(@"should return nil", ^{
                [[base64 encode:nil] shouldBeNil];
            });
        });
        
        context(@"decode nil string", ^{
            it(@"should return nil", ^{
                [[base64 decode:nil] shouldBeNil]; 
            });
        });
        
        context(@"encode empty data", ^{
            it(@"should return nil", ^{
                [[base64 encode:[NSData data]] shouldBeNil];
            });            
        });
        
        context(@"decode empty string", ^{
            it(@"should return nil", ^{
                [[base64 decode:@""] shouldBeNil]; 
            });            
        });
        
        context(@"ascii 1 char", ^{
            NSString* text = @"YQ==";
            NSData* binary = [@"a" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 2 chars", ^{
            NSString* text = @"YWI=";
            NSData* binary = [@"ab" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 3 chars", ^{
            NSString* text = @"YWJj";
            NSData* binary = [@"abc" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 4 chars", ^{
            NSString* text = @"YWJjZA==";
            NSData* binary = [@"abcd" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 5 chars", ^{
            NSString* text = @"YWJjZGU=";
            NSData* binary = [@"abcde" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 6 chars", ^{
            NSString* text = @"YWJjZGVm";
            NSData* binary = [@"abcdef" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"ascii 8 chars which contain valid symbols", ^{
            NSString* text = @"YWJjZGVmKy8=";
            NSData* binary = [@"abcdef+/" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"multibyte 1 char", ^{
            NSString* text = @"44GC";
            NSData* binary = [@"あ" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"multibyte 2 chars", ^{
            NSString* text = @"44GC44GE";
            NSData* binary = [@"あい" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });

        context(@"multibyte 3 chars", ^{
            NSString* text = @"44GC44GE44GG";
            NSData* binary = [@"あいう" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"decode string which length is invalid", ^{
            it (@"should be rejected", ^{
                [[base64 decode:@"a"] shouldBeNil];
                [[base64 decode:@"ab"] shouldBeNil];
                [[base64 decode:@"abc"] shouldBeNil];
                [[base64 decode:@"abcde"] shouldBeNil];
                [[base64 decode:@"abcdef"] shouldBeNil];
            });
        });
        
        context(@"decode string which contains invalid chars", ^{
            for (int i=0; i<=127; i++) {
                if (i >= 48 && i <= 57) continue;
                if (i >= 65 && i <= 90) continue;
                if (i >= 97 && i <= 122) continue;
                if (i == 43 || i == 47) continue;
                NSString* t = [NSString stringWithFormat:@"should be rejected '%c'", i]; 
                it (t, ^{
                [[base64 decode:[NSString stringWithFormat:@"%cXXX", i]] shouldBeNil];
            }); 
            }
        });
        
    });
    
    context(@"urlsafe", ^{
        
        beforeEach(^{
            base64 = [NNBase64 base64URLSafe]; 
        });
        
        context(@"encode nil data", ^{
            it(@"should return nil", ^{
                [[base64 encode:nil] shouldBeNil];
            });
        });
        
        context(@"decode nil string", ^{
            it(@"should return nil", ^{
                [[base64 decode:nil] shouldBeNil]; 
            });
        });
        
        context(@"encode empty data", ^{
            it(@"should return nil", ^{
                [[base64 encode:[NSData data]] shouldBeNil];
            });            
        });
        
        context(@"decode empty string", ^{
            it(@"should return nil", ^{
                [[base64 decode:@""] shouldBeNil]; 
            });            
        });
        
        context(@"ascii 1 char", ^{
            NSString* text = @"YQ==";
            NSData* binary = [@"a" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 2 chars", ^{
            NSString* text = @"YWI=";
            NSData* binary = [@"ab" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 3 chars", ^{
            NSString* text = @"YWJj";
            NSData* binary = [@"abc" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 4 chars", ^{
            NSString* text = @"YWJjZA==";
            NSData* binary = [@"abcd" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 5 chars", ^{
            NSString* text = @"YWJjZGU=";
            NSData* binary = [@"abcde" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 6 chars", ^{
            NSString* text = @"YWJjZGVm";
            NSData* binary = [@"abcdef" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"ascii 8 chars which contain valid symbols", ^{
            NSString* text = @"YWJjZGVmLV8=";
            NSData* binary = [@"abcdef-_" dataUsingEncoding:NSASCIIStringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"multibyte 1 char", ^{
            NSString* text = @"44GC";
            NSData* binary = [@"あ" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"multibyte 2 chars", ^{
            NSString* text = @"44GC44GE";
            NSData* binary = [@"あい" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"multibyte 3 chars", ^{
            NSString* text = @"44GC44GE44GG";
            NSData* binary = [@"あいう" dataUsingEncoding:NSUTF8StringEncoding];
            it(@"encoded should be same as expected text", ^{
                [[[base64 encode:binary] should] equal:text];
            });
            it(@"decoded should be same as expected binary", ^{
                [[[base64 decode:text] should] equal:binary];
            });
        });
        
        context(@"decode string which length is invalid", ^{
            it (@"should be rejected", ^{
                [[base64 decode:@"a"] shouldBeNil];
                [[base64 decode:@"ab"] shouldBeNil];
                [[base64 decode:@"abc"] shouldBeNil];
                [[base64 decode:@"abcde"] shouldBeNil];
                [[base64 decode:@"abcdef"] shouldBeNil];
            });
        });
        
        context(@"decode string which contains invalid chars", ^{
            for (int i=0; i<=127; i++) {
                if (i >= 48 && i <= 57) continue;
                if (i >= 65 && i <= 90) continue;
                if (i >= 97 && i <= 122) continue;
                if (i == 45 || i == 95) continue;
                NSString* t = [NSString stringWithFormat:@"should be rejected '%c'", i]; 
                it (t, ^{
                    [[base64 decode:[NSString stringWithFormat:@"%cXXX", i]] shouldBeNil];
                }); 
            }
        });
        
    });

});

SPEC_END
