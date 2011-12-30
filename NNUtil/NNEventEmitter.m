#import "NNEventEmitter.h"
#import "NNDebug.h"

@interface NNEventEmitter()

@property(nonatomic, retain) NSMutableDictionary* eventListenerGroup;
@property(nonatomic, retain) NSMutableDictionary* onceEventListenerGroup;

- (NSMutableArray*)listeners:(NSMutableDictionary*)listenerGroup eventName:(NSString*)eventName;
- (void)fire:(NSMutableSet*)listeners event:(NNEvent*)event;

@end

@implementation NNEventEmitter

@synthesize eventListenerGroup = eventListenerGroup_;
@synthesize onceEventListenerGroup = onceEventListenerGroup_;

- (id)init
{
    self = [super init];
    if (self) {
        self.eventListenerGroup = [NSMutableDictionary dictionary];
        self.onceEventListenerGroup = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    self.eventListenerGroup = nil;
    self.onceEventListenerGroup = nil;
    [super dealloc];
}

- (void)on:(NSString*)eventName listener:(NNEventListener)listener
{
    TRACE();
    NSMutableArray* listeners = [self listeners:self.eventListenerGroup eventName:eventName];
    [listeners addObject:[listener copy]];
}

- (void)once:(NSString*)eventName listener:(NNEventListener)listener
{
    TRACE();
    NSMutableArray* listeners = [self listeners:self.onceEventListenerGroup eventName:eventName];
    [listeners addObject:[listener copy]];
}

- (void)emit:(NSString*)eventName;
{
    [self emit:eventName event:nil];
}

- (void)emit:(NSString*)eventName event:(NNEvent*)event
{
    TRACE();
    [self fire:[self.eventListenerGroup objectForKey:eventName] event:event];
    NSMutableSet* onceListeners = [self.onceEventListenerGroup objectForKey:eventName];
    [self fire:onceListeners event:event];
    [onceListeners removeAllObjects]; 
}

- (NSMutableArray*)listeners:(NSMutableDictionary*)listenerGroup eventName:(NSString*)eventName
{
    NSMutableArray* list = [listenerGroup objectForKey:eventName];
    if (!list) {
        list = [NSMutableArray array];
        [listenerGroup setObject:list forKey:eventName];
    }
    return list;
}

- (void)fire:(NSMutableSet*)listeners event:(NNEvent*)event
{
    TRACE();
    if (!listeners) return;
    dispatch_queue_t queue = dispatch_get_main_queue();
    for (NNEventListener block in listeners) {
        dispatch_async(queue, ^{
            block(event);
        });
    }
    
}

@end
