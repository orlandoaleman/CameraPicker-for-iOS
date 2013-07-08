//
//  TTCameraPreviewControllerDelegate
//  TTCameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import <UIKit/UIKit.h>

@class TTCameraPreviewController;


@protocol TTCameraPreviewControllerDelegate <NSObject>
- (void)cameraPreviewControllerWantsRetake:(TTCameraPreviewController *)controller;
- (void)cameraPreviewControllerDidFinish:(TTCameraPreviewController *)controller;
@end
