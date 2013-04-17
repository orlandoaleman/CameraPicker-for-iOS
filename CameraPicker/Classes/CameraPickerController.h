//
//  CameraPickerController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>
#import "CameraPreviewController.h"
#import "CameraPickerControllerDelegate.h"



@interface CameraPickerController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, CameraPreviewControllerDelegate>

@property (nonatomic, weak) id <CameraPickerControllerDelegate> delegate;

- (UIImagePickerController *)imagePickerController;

@end
