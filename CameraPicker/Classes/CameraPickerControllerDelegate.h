//
//  CameraPickerControllerDelegate
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>


@class CameraPickerController;


@protocol CameraPickerControllerDelegate
- (void)cameraPickerController:(CameraPickerController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info;
- (void)cameraPickerControllerDidCancel:(CameraPickerController *)controller;
- (void)cameraPickerControllerWantsGallery:(CameraPickerController *)controller;
@end

