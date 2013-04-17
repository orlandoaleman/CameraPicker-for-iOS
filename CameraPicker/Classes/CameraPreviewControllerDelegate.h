//
//  CameraPreviewControllerDelegate
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>

@class CameraPreviewController;


@protocol CameraPreviewControllerDelegate <NSObject>
- (void)cameraPreviewControllerWantsRetake:(CameraPreviewController *)controller;
- (void)cameraPreviewControllerDidFinish:(CameraPreviewController *)controller;
@end
