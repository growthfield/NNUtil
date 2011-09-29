#import "NNBase64Tests.h"

@implementation NNBase64Tests

- (void)setUp
{
    [super setUp];
    base64_ = [NNBase64 base64];
    base64URLSafe_ = [NNBase64 base64URLSafe];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNil
{
    STAssertEqualObjects([base64_ encode:nil], @"", @"");
    STAssertEqualObjects([base64URLSafe_ encode:nil], @"", @"");
    STAssertEqualObjects([base64_ decode:nil], [NSData data], @"");
    STAssertEqualObjects([base64URLSafe_ decode:nil], [NSData data], @"");
}

- (void)testEmpty
{
    STAssertEqualObjects([base64_ encode:[NSData data]], @"", @"");
    STAssertEqualObjects([base64URLSafe_ encode:[NSData data]], @"", @"");
    STAssertEqualObjects([base64_ decode:@""], [NSData data], @"");
    STAssertEqualObjects([base64URLSafe_ decode:@""], [NSData data], @"");
}

- (void)test1Byte
{
    NSString* text = @"YQ==";
    NSData* binary = [@"a" dataUsingEncoding:NSASCIIStringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test2Byte
{
    NSString* text = @"YWI=";
    NSData* binary = [@"ab" dataUsingEncoding:NSASCIIStringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test3Byte
{
    NSString* text = @"YWJj";
    NSData* binary = [@"abc" dataUsingEncoding:NSASCIIStringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test4Byte
{
    NSString* text = @"YWJjZA==";
    NSData* binary = [@"abcd" dataUsingEncoding:NSASCIIStringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test5Byte
{
    NSString* text = @"YWJjZGU=";
    NSData* binary = [@"abcde" dataUsingEncoding:NSASCIIStringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test1MultiByte
{
    NSString* text = @"44GC";
    NSData* binary = [@"あ" dataUsingEncoding:NSUTF8StringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test2MultiByte
{
    NSString* text = @"44GC44GE";
    NSData* binary = [@"あい" dataUsingEncoding:NSUTF8StringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}

- (void)test3MultiByte
{
    NSString* text = @"44GC44GE44GG";
    NSData* binary = [@"あいう" dataUsingEncoding:NSUTF8StringEncoding];
    STAssertEqualObjects([base64_ encode:binary], text, @"");
    STAssertEqualObjects([base64URLSafe_ encode:binary], text, @"");
    STAssertEqualObjects([base64_ decode:text], binary, @"");
    STAssertEqualObjects([base64URLSafe_ decode:text], binary, @"");    
}


- (void)testInvalidEncodedTextLength;
{
    STAssertNil([base64_ decode:@"a"], @"");
    STAssertNil([base64_ decode:@"ab"], @"");
    STAssertNil([base64_ decode:@"abc"], @"");
    STAssertNotNil([base64_ decode:@"abcd"], @"");    
    STAssertNil([base64_ decode:@"abcde"], @"");
    STAssertNil([base64_ decode:@"abcdef"], @"");
    STAssertNil([base64_ decode:@"=abc"], @"");
    STAssertNil([base64_ decode:@"a=bc"], @"");    
    STAssertNil([base64_ decode:@"abcd=fg"], @"");
    STAssertNil([base64_ decode:@"a\n"], @"");
    STAssertNil([base64_ decode:@"a\nb"], @"");
    
}

@end
