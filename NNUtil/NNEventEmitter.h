#import <Foundation/Foundation.h>
#import "NNEvent.h"

typedef void (^NNEventCallback)(NNEvent* event);

@interface NNEventEmitter : NSObject
{
   @private
    NSMutableDictionary* eventListenerGroup_;
    NSMutableDictionary* onceEventListenerGroup_;    

}

- (id)init;
- (void)on:(NSString*)eventName callback:(NNEventCallback)callback;
- (void)once:(NSString*)eventName callback:(NNEventCallback)callback;
- (void)emit:(NSString*)eventName;
- (void)emit:(NSString*)eventName event:(NNEvent*)event;

@end
