#import "NNEvent.h"

@interface NNEvent()

@property(nonatomic, retain) NSArray* values;

@end

@implementation NNEvent

@synthesize values = values_;

+ (id)event
{
    return [[[self alloc] initWithValue:nil, nil] autorelease];
}

+ (id)event:(id)firstValue, ...
{
    va_list args;
    va_start(args, firstValue);
    id obj = [[[self alloc] initWithValue:firstValue args:args] autorelease];
    va_end(args);
    return obj;
}

- (id)initWithValue:(id)firstValue, ...
{
    va_list args;
    va_start(args, firstValue);
    self = [self initWithValue:firstValue args:args];
    va_end(args);
    return self;
}

- (id)initWithValue:(id)firstValue args:(va_list)args
{
    self = [super init];
    if (self) {
        id val;
        NSMutableArray* array = [NSMutableArray array];
        [array addObject:firstValue ? firstValue : [NSNull null]];
        while ((val = va_arg(args, id))) {
            [array addObject:val];
        }
        self.values = array;
    }
    return self;
}

- (void)dealloc
{
    self.values = nil;
    [super dealloc];
}

- (id)value:(NSUInteger)index
{
    if (self.values.count <= index) {
        return nil;
    }
    id obj = [self.values objectAtIndex:index];
    return [NSNull null] == obj ? nil : obj;
}

@end
