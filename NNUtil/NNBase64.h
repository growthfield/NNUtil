#import <Foundation/Foundation.h>

@interface NNBase64 : NSObject
{
    @private
    unsigned char* charTable_;
    unsigned char reverseCharTable_[128];
}

+ (id)base64;
+ (id)base64URLSafe;
- (id)initWithCharacters:(const char*)chars;
- (NSString*)encode:(NSData*)data;
- (NSData*)decode:(NSString*)str;

@end
