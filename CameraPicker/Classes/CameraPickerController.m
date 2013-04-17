//
//  CameraPickerController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "CameraPickerController.h"
#import "UIBarButtonItem+Custom.h"
#import "UIImage+Extras.h"


@interface CameraPickerController () {
    NSDictionary *lastPhotoMediaInfo_;
}

- (void)setup;

- (IBAction)takePhoto:(id)sender;
- (IBAction)cancelCamera:(id)sender;
- (IBAction)chooseFromGallery:(id)sender;
- (IBAction)switchCamera:(id)sender;
- (IBAction)switchFlash:(id)sender;

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) UIImageView *focusView;

@property (weak, nonatomic) IBOutlet UIButton *switchFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchCameraBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseFromGalleryBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *takeBtn;
@end


@implementation CameraPickerController

- (id)init
{
    if (self = [super initWithNibName:@"CameraView" bundle:nil]) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.imagePickerController.showsCameraControls = NO;
    self.imagePickerController.delegate = self;
    [self.imagePickerController.cameraOverlayView addSubview:self.view];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect viewFrame = self.imagePickerController.view.frame;
    self.imagePickerController.view.frame = viewFrame;
  
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    recognizer.cancelsTouchesInView = NO;
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
  
    [self.takeBtn customViewButtonWithImage:@"camera-take"];
    [self refreshFlashModeButton];
  
    UIImage *image = [UIImage imageNamed:@"focus-crosshair"];
    self.focusView = [[UIImageView alloc] initWithImage:image];
    self.focusView.alpha = 0;
    [self.view addSubview:self.focusView];
}


- (void)refreshFlashModeButton
{
    BOOL flashAvailable = [UIImagePickerController isFlashAvailableForCameraDevice:self.imagePickerController.cameraDevice];
    self.switchFlashBtn.hidden = !flashAvailable;
    
    
    if (flashAvailable) {
        UIImagePickerControllerCameraFlashMode flashMode = self.imagePickerController.cameraFlashMode;
        
        UIImage *image = nil;
        switch (flashMode) {
            case UIImagePickerControllerCameraFlashModeOn:
                image = [UIImage imageNamed:@"camera-flash"];
                break;
            case UIImagePickerControllerCameraFlashModeAuto:
                image = [UIImage imageNamed:@"camera-flashauto"];
                break;
            case UIImagePickerControllerCameraFlashModeOff:
                image = [UIImage imageNamed:@"camera-flashoff"];
                break;
        }
        [self.switchFlashBtn setImage:image forState:UIControlStateNormal];
    }
}



#pragma mark - Actions

- (void)chooseFromGallery:(id)sender
{
    [self.delegate cameraPickerControllerWantsGallery:self];
}


- (IBAction)switchCamera:(id)sender
{
    UIImagePickerControllerCameraDevice currentDevice = self.imagePickerController.cameraDevice;
    UIImagePickerControllerCameraDevice nextDevice = currentDevice == UIImagePickerControllerCameraDeviceRear ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
    
    if ([UIImagePickerController isCameraDeviceAvailable:nextDevice]) {
        // Animated switching between rear and front camera
        [UIView transitionWithView:self.imagePickerController.view
                          duration:1.0
                           options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            self.imagePickerController.cameraDevice = nextDevice;
                            [self refreshFlashModeButton];
                        } completion:NULL];
    }
}


- (IBAction)switchFlash:(id)sender
{
    UIImagePickerControllerCameraFlashMode nextFlashMode;
    switch (self.imagePickerController.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeAuto:
            nextFlashMode = UIImagePickerControllerCameraFlashModeOn;
            break;
        case UIImagePickerControllerCameraFlashModeOff:
            nextFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            break;
        case UIImagePickerControllerCameraFlashModeOn:
            nextFlashMode = UIImagePickerControllerCameraFlashModeOff;
            break;
    }
    self.imagePickerController.cameraFlashMode = nextFlashMode;
    [self refreshFlashModeButton];
}


- (void)cancelCamera:(id)sender
{
    [self.delegate cameraPickerControllerDidCancel:self];
}


- (IBAction)takePhoto:(id)sender
{
    [self.imagePickerController takePicture];
}


#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    lastPhotoMediaInfo_ = info;
    
    CameraPreviewController *previewVC = [[CameraPreviewController alloc] init];
    previewVC.image = info[UIImagePickerControllerOriginalImage];
    previewVC.delegate = self;
    [self.imagePickerController pushViewController:previewVC animated:YES];
}


#pragma mark - CameraPreviewController

- (void)cameraPreviewControllerWantsRetake:(CameraPreviewController *)controller
{
    [self.imagePickerController popViewControllerAnimated:YES];
}


- (void)cameraPreviewControllerDidFinish:(CameraPreviewController *)picker
{
    [self.delegate cameraPickerController:self didFinishWithPhotoWithInfo:lastPhotoMediaInfo_];
    lastPhotoMediaInfo_ = nil;
}


#pragma mark - UIGestureRecognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isEqual:self.view]) {
      return YES;
    }
    return NO;
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
  CGPoint touchPoint = [recognizer locationInView:self.view];
  
  CGSize originalSize = self.focusView.frame.size;
  self.focusView.frame = CGRectMake(touchPoint.x, touchPoint.y, originalSize.width, originalSize.height);
  self.focusView.transform = CGAffineTransformMakeScale(1.50, 1.50);
  
  [UIView animateWithDuration:0.5
                        delay:0
                      options:UIViewAnimationCurveEaseOut
                   animations:^{
                     self.focusView.alpha = 1;
                     self.focusView.transform = CGAffineTransformIdentity;
                   }
                   completion:^(BOOL finished) {
                     if (!finished) return;
                     [UIView animateWithDuration:0.1
                                           delay:0.0
                                         options:UIViewAnimationCurveEaseIn
                                      animations:^{
                                        [UIView setAnimationRepeatCount:2];
                                        self.focusView.alpha = 0;
                                      }
                                      completion:NULL];
                   }];
}

@end
