//
//  CameraPickerControllerDelegate
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>


@class TTCameraPickerController;


@protocol TTCameraPickerControllerDelegate <NSObject>

- (void)cameraPickerController:(TTCameraPickerController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info;
- (void)cameraPickerControllerDidCancel:(TTCameraPickerController *)controller;

@optional
- (void)cameraPickerControllerWantsGallery:(TTCameraPickerController *)controller;

@end

