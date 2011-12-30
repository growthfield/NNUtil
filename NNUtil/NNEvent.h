#import <Foundation/Foundation.h>

@interface NNEvent : NSObject
{
    @private
    NSArray* values_;
}

+ (id)event;
+ (id)event:(id)firstValue, ...NS_REQUIRES_NIL_TERMINATION;
- (id)initWithValue:(id)firstValue, ...NS_REQUIRES_NIL_TERMINATION;
- (id)initWithValue:(id)firstValue args:(va_list) args;
- (id)value:(NSUInteger)index;

@end
