#import "NNEvent.h"

@interface NNEvent()

@property(nonatomic, retain) NSArray* array;

@end

@implementation NNEvent

@synthesize array = array_;

+ (id)event
{
    return [[[self alloc] initWithValues:nil, nil] autorelease];
}

+ (id)event:(id)firstValue, ...
{
    va_list args;
    va_start(args, firstValue);
    id obj = [[[self alloc] initWithValues:firstValue args:args] autorelease];
    va_end(args);
    return obj;
}

- (id)initWithValues:(id)firstValue, ...
{
    va_list args;
    va_start(args, firstValue);
    self = [self initWithValues:firstValue args:args];
    va_end(args);
    return self;
}

- (id)initWithValues:(id)firstValue args:(va_list)args
{
    self = [super init];
    if (self) {
        id val;
        NSMutableArray* tmp = [NSMutableArray array];
        while ((val = va_arg(args, id))) {
            [tmp addObject:val];
        }
        if (firstValue || tmp.count > 0) {
            NSMutableArray* array = [NSMutableArray array];
            [array addObject:firstValue ? firstValue : [NSNull null]];
            [array addObjectsFromArray:tmp];
            self.array = array;
        }
    }
    return self;
}

- (void)dealloc
{
    self.array = nil;
    [super dealloc];
}

- (id)value:(NSUInteger)index
{
    if (self.array.count <= index) {
        return nil;
    }
    id obj = [self.array objectAtIndex:index];
    return [NSNull null] == obj ? nil : obj;
}

- (NSArray*)values
{
    return self.array;
}

@end
