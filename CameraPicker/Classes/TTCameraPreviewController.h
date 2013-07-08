//
//  CameraPreviewController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>

@protocol TTCameraPreviewControllerDelegate;

@interface TTCameraPreviewController : UIViewController

@property (nonatomic, copy) UIImage *image;
@property (nonatomic, weak) id<TTCameraPreviewControllerDelegate> delegate;

@end

@protocol TTCameraPreviewControllerDelegate <NSObject>
- (void)cameraPreviewControllerWantsRetake:(TTCameraPreviewController *)controller;
- (void)cameraPreviewControllerDidFinish:(TTCameraPreviewController *)controller;
@end
