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


@protocol CameraPickerControllerDelegate;

@interface CameraPickerController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, CameraPreviewControllerDelegate>

- (UIImagePickerController *)imagePickerController;
@property (nonatomic, weak) id <CameraPickerControllerDelegate> delegate;
@end


@protocol CameraPickerControllerDelegate
- (void)cameraPickerController:(CameraPickerController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info;
- (void)cameraPickerControllerDidCancel:(CameraPickerController *)controller;
- (void)cameraPickerControllerWantsGallery:(CameraPickerController *)controller;
@end

