//
//  CameraPickerController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "CameraPickerController.h"
#import "UIImage+Extras.h"


@interface CameraViewController () {
    NSDictionary *lastPhotoMediaInfo_;
}

- (IBAction)takePhoto:(id)sender;
- (IBAction)cancelCamera:(id)sender;
- (IBAction)chooseFromGallery:(id)sender;
- (IBAction)switchCamera:(id)sender;
- (IBAction)switchFlash:(id)sender;

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIButton *switchFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchCameraBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseFromGalleryBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *takeBtn;
@end




@implementation CameraViewController

- (id)init
{
    if (self = [super initWithNibName:@"CameraViewController" bundle:nil]) {
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.imagePickerController.showsCameraControls = NO;
    
    [self.takeBtn customViewButtonWithImage:@"camera-take"];
    
    CGRect viewFrame = self.view.frame;
    CGRect cameraViewFrame = viewFrame;

    self.imagePickerController.view.frame = cameraViewFrame;
    [self.view addSubview:self.imagePickerController.view];

    [self.view bringSubviewToFront:self.bottomBar];
    [self.view bringSubviewToFront:self.switchCameraBtn];
    [self.view bringSubviewToFront:self.switchFlashBtn];

    [self refreshFlashModeButton];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    // Desactivo el ocultado de la barra de estado
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
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
        self.switchFlashBtn.imageView.image = image;
    }
}


#pragma mark - Actions

- (void)chooseFromGallery:(id)sender
{
    [self.delegate cameraControllerWantsGallery:self];
}

- (IBAction)switchCamera:(id)sender
{
    UIImagePickerControllerCameraDevice currentDevice = self.imagePickerController.cameraDevice;
    UIImagePickerControllerCameraDevice nextDevice = currentDevice == UIImagePickerControllerCameraDeviceRear ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;

    if ([UIImagePickerController isCameraDeviceAvailable:nextDevice]) {
        // Animated switch between rear and front camera
        [UIView transitionWithView:self.imagePickerController.view
                          duration:1.0
                           options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
            self.imagePickerController.cameraDevice = nextDevice;
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
    [self.delegate cameraViewControllerDidCancel:self];
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
    previewVC.image = [lastPhotoMediaInfo_[UIImagePickerControllerOriginalImage] fixOrientation];
    previewVC.delegate = self;

    [self.navigationController pushViewController:previewVC animated:YES];
}


#pragma mark - CameraPreviewController

- (void)cameraPreviewControllerWantsRetake:(CameraPreviewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)cameraPreviewControllerDidFinish:(CameraPreviewController *)picker
{
    [self.delegate cameraViewController:self didFinishWithPhotoWithInfo:lastPhotoMediaInfo_];
    lastPhotoMediaInfo_ = nil;
}

@end



@implementation CameraPickerController

- (id)init
{
    self = [super initWithRootViewController:[[CameraViewController alloc] init]];
    if (self) {
        _cameraViewController = self.viewControllers[0];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarHidden = YES;
}

@end