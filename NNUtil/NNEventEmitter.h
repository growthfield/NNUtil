#import <Foundation/Foundation.h>
#import "NNEvent.h"

typedef void (^NNEventListener)(NNEvent* event);

@interface NNEventEmitter : NSObject
{
   @private
    NSMutableDictionary* eventListenerGroup_;
    NSMutableDictionary* onceEventListenerGroup_;    

}

- (id)init;
- (void)on:(NSString*)eventName listener:(NNEventListener)listener;
- (void)once:(NSString*)eventName listener:(NNEventListener)listener;
- (void)emit:(NSString*)eventName;
- (void)emit:(NSString*)eventName event:(NNEvent*)event;

@end
