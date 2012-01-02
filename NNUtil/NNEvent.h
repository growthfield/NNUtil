#import <Foundation/Foundation.h>

@interface NNEvent : NSObject
{
    @private
    NSArray* array_;
}

+ (id)event;
+ (id)event:(id)firstValue, ...NS_REQUIRES_NIL_TERMINATION;
- (id)initWithValues:(id)firstValue, ...NS_REQUIRES_NIL_TERMINATION;
- (id)initWithValues:(id)firstValue args:(va_list) args;
- (id)value:(NSUInteger)index;
- (NSArray*)values;

@end
