//
//  TTCameraPreviewController
//  TTCameraPicker
//
//  Created by Orlando Aleman Ortiz on 15/04/13.
//
//

#import "TTCameraPreviewController.h"
#import "UIScrollView+Extras.h"
#import "UIImage+Extras.h"


@interface TTCameraPreviewController () {
    UITapGestureRecognizer *doubletapRecognizer_;
}

- (IBAction)done:(id)sender;
- (IBAction)retake:(id)sender;

@property (nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *retakeBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end


@implementation TTCameraPreviewController

- (id)init
{
    self = [super initWithNibName:@"TTCameraPreviewView" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self refreshView];
}


- (void)createView
{
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    

    self.imageView = [[UIImageView alloc] init];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView addSubview:self.imageView];
    

    self.titleBtn.title = NSLocalizedString(@"Preview", nil);
    self.doneBtn.title = NSLocalizedString(@"Use", nil);
    

    doubletapRecognizer_ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandler)];
    doubletapRecognizer_.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubletapRecognizer_];
}


- (void)refreshView
{
    if (!self.image) {
        return;
    }
    
    CGRect scrollFrame = self.scrollView.bounds;

    UIImage *image = [self.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit
                                         bounds:scrollFrame.size
                                        interpolationQuality:kCGInterpolationMedium];

    self.imageView.image = image;
    CGSize imageSize = image.size;
    self.imageView.frame = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    self.scrollView.contentSize = imageSize;

    CGFloat widthRatio = scrollFrame.size.width / imageSize.width;
    CGFloat heightRatio = scrollFrame.size.height / imageSize.height;
    CGFloat initialZoom = MIN(heightRatio, widthRatio);
    
    self.scrollView.minimumZoomScale = initialZoom;
    self.scrollView.maximumZoomScale = 4;
    self.scrollView.zoomScale = initialZoom;
}


#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate cameraPreviewControllerDidFinish:self];
}


- (IBAction)retake:(id)sender
{
    [self.delegate cameraPreviewControllerWantsRetake:self];
}


- (void)doubleTapHandler
{
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        // Zoom-out
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
    else {
        // Zoom-in
        CGRect zoomRect = [self zoomRectForScale:self.scrollView.maximumZoomScale
                                      withCenter:[doubletapRecognizer_ locationInView:doubletapRecognizer_.view]];
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    
    zoomRect.size.height = CGRectGetHeight(self.imageView.frame) / scale;
    zoomRect.size.width = CGRectGetWidth(self.imageView.frame) / scale;
    
    center = [self.imageView convertPoint:center fromView:self.scrollView];
    
    zoomRect.origin.x = center.x - ((zoomRect.size.width / 2.0));
    zoomRect.origin.y = center.y - ((zoomRect.size.height / 2.0));
    
    return zoomRect;
}


#pragma mark - UIScrollView delegated

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageView.frame = [self.scrollView centeredFrameForView:self.imageView];
}


@end
