#import <UIKit/UIKit.h>

@protocol FaceTrackerPipelineDelegate <NSObject>
- (void)recievedFrame:(UIImage * __nonnull)image withPoints:(nullable NSArray<NSValue *> *)points;
@end

@interface FaceTrackerPipeline : NSObject

@property (weak, nonatomic, nullable) id <FaceTrackerPipelineDelegate> delegate;

- (void)startWithCompletionHandler:(void (^ __nullable)())completion;
- (void)stop;

- (void)swapCamera;
- (void)reset;

@end
