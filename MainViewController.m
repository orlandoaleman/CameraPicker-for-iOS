//
//  MainViewController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "MainViewController.h"

@interface MainViewController ()
- (IBAction)takePhotoFromCamera;
- (IBAction)takePhotoFromSavedPhotosAlbum;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end



@implementation MainViewController


#pragma mark - CameraViewController delegate

- (void)cameraViewController:(CameraViewController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        [controller.navigationController popToRootViewControllerAnimated:NO];
        self.imageView.image = info[UIImagePickerControllerOriginalImage];
    }];
}


- (void)cameraViewControllerDidCancel:(CameraViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}


- (void)cameraControllerWantsGallery:(CameraViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self takePhotoFromSavedPhotosAlbum];
    }];
}


#pragma mark - Actions

- (void)showImagePicker
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self takePhotoFromCamera];
    }
    else {
        [self takePhotoFromSavedPhotosAlbum];
    }
}


- (IBAction)takePhotoFromCamera
{
    CameraPickerController *cameraPickerController = [[CameraPickerController alloc] init];
    cameraPickerController.cameraViewController.delegate = self;
    [self presentViewController:cameraPickerController animated:YES completion:NULL];
}


- (void)takePhotoFromSavedPhotosAlbum
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    photoPicker.delegate = self;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}


#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView.image = [info valueForKey:UIImagePickerControllerOriginalImage];    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end