//
//  CameraPreviewController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>

@protocol CameraPreviewControllerDelegate;

@interface CameraPreviewController : UIViewController

@property (nonatomic) UIImage *image;
@property (nonatomic, weak) id<CameraPreviewControllerDelegate> delegate;
@end

@protocol CameraPreviewControllerDelegate <NSObject>
- (void)cameraPreviewControllerWantsRetake:(CameraPreviewController *)controller;
- (void)cameraPreviewControllerDidFinish:(CameraPreviewController *)controller;
@end
