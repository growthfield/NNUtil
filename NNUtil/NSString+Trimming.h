#import <Foundation/Foundation.h>

@interface NSString(Trimming)

- (NSString*)stringByLeftTrimmingCharactersInSet:(NSCharacterSet*)characterSet;
- (NSString*)stringByRightTrimmingCharactersInSet:(NSCharacterSet*)characterSet;

@end
