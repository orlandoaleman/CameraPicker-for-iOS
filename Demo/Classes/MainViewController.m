//
//  MainViewController
//  CameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "MainViewController.h"

@interface MainViewController () {
    CameraPickerController *cameraPickerController_;
}
- (IBAction)takePhotoFromCamera;
- (IBAction)takePhotoFromSavedPhotosAlbum;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end



@implementation MainViewController


#pragma mark - CameraPickerController delegate

- (void)cameraPickerController:(CameraPickerController *)controller didFinishWithPhotoWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        [controller.navigationController popToRootViewControllerAnimated:NO];
        self.imageView.image = info[UIImagePickerControllerOriginalImage];
    }];
}


- (void)cameraPickerControllerDidCancel:(CameraPickerController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)cameraPickerControllerWantsGallery:(CameraPickerController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self takePhotoFromSavedPhotosAlbum];
    }];
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


- (void)takePhotoFromCamera
{
    cameraPickerController_ = [[CameraPickerController alloc] init];
    cameraPickerController_.delegate = self;
    [self presentViewController:cameraPickerController_.imagePickerController animated:YES completion:NULL];
}


- (void)takePhotoFromSavedPhotosAlbum
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    photoPicker.delegate = self;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

@end