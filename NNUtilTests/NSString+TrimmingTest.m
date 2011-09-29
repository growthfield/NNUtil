#import "NSString+TrimmingTest.h"
#import "NSString+Trimming.h"

@implementation NSString_TrimmingTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLeftTrimmingEmpty
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"";
    NSString* result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"", @"");
}


- (void)testLeftTrimming
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"===abc";
    NSString* result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"abc", @"");

    str = @"===a=b";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"a=b", @"");
    
    str = @"===a=b=";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"a=b=", @"");

    str = @"===";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"", @"");
}

- (void)testLeftTrimmingMultibytes
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"===＝テスト";
    NSString* result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"＝テスト", @"");
    
    str = @"===＝テ=スト";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"＝テ=スト", @"");
    
    str = @"===＝テ=スト=";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"＝テ=スト=", @"");    
}

- (void)testRightTrimmingEmpty
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"";
    NSString* result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"", @"");
}

- (void)testRightTrimming
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"abc===";
    NSString* result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"abc", @"");
    
    str = @"a=b===";
    result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"a=b", @"");
    
    str = @"=a=b===";
    result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"=a=b", @"");
    
    str = @"===";
    result = [str stringByLeftTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"", @"");
}

- (void)testRightTrimmingMultibytes
{
    NSCharacterSet* cset = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSString* str = @"テスト＝===";
    NSString* result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"テスト＝", @"");
    
    str = @"テ=スト＝===";
    result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"テ=スト＝", @"");
    
    str = @"=テ=スト＝===";
    result = [str stringByRightTrimmingCharactersInSet:cset];
    STAssertEqualObjects(result, @"=テ=スト＝", @"");    
}



@end
