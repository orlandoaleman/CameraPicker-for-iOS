//
//  CameraPickerController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>
#import "CameraPreviewController.h"
#import "UIBarButtonItem+Custom.h"


@protocol CameraViewControllerDelegate;

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CameraPreviewControllerDelegate>

@property (nonatomic, readonly) UIImagePickerController *imagePickerController;
@property (nonatomic, weak) id <CameraViewControllerDelegate> delegate;
@end


@protocol CameraViewControllerDelegate
- (void)cameraViewController:(CameraViewController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info;
- (void)cameraViewControllerDidCancel:(CameraViewController *)controller;
- (void)cameraControllerWantsGallery:(CameraViewController *)controller;
@end



@interface CameraPickerController : UINavigationController
@property (nonatomic, weak) CameraViewController *cameraViewController;
@end
