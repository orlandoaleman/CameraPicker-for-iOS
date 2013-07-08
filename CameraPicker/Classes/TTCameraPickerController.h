//
//  TTCameraPickerController
//  TTCameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>
#import "TTCameraPreviewController.h"
#import "TTCameraPickerControllerDelegate.h"



@interface TTCameraPickerController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, TTCameraPreviewControllerDelegate>

- (UIImagePickerController *)imagePickerController;

@property (nonatomic, weak) id <TTCameraPickerControllerDelegate> delegate;
@end
