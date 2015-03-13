//
//  ShowPhotoViewController.m
//  TheAssignment


#import "ShowPhotoViewController.h"

@interface ShowPhotoViewController ()

@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",self.imageName]];
    self.photoImageView.image = [UIImage imageWithContentsOfFile:filePath];
    self.photoImage = [UIImage imageWithContentsOfFile:filePath];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(260, 60, 60, 400)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark image filter methods

-(void)imageFun {
    
    self.scrollView.contentSize = CGSizeMake(60, 50 *26);
    int row = 0;
    
    for(int i = 0; i < 25; ++i) {
        
        UIButton * thumbButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        thumbButton.frame = CGRectMake(10,row*50+20 , 45, 45);
        thumbButton.tag = row;
        thumbButton.layer.borderWidth = 1;
        thumbButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [thumbButton addTarget:self
                        action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (row == 25) {
            row = 0;
        } else {
            row++;
        }
        switch (i) {
            case 0:
                [thumbButton setImage:_photoImage forState:UIControlStateNormal] ;
                break;
            case 1:
                [thumbButton setImage:[self CIBloom:_photoImage] forState:UIControlStateNormal];
                break;
            case 2:
                [thumbButton setImage:[self CICircularScreen:_photoImage]forState:UIControlStateNormal];
                break;
            case 3:
                [thumbButton setImage:[self CIColorInvert:_photoImage]forState:UIControlStateNormal];
                break;
            case 4:
                [thumbButton setImage:[self CIColorMap:_photoImage]forState:UIControlStateNormal];
                break;
            case 5:
                [thumbButton setImage:[self CIColorMonochrome:_photoImage]forState:UIControlStateNormal];
                break;
            case 6:
                [thumbButton setImage:[self CIColorPosterize:_photoImage]forState:UIControlStateNormal];
                break;
            case 7:
                [thumbButton setImage:[self CIExposureAdjust:_photoImage]forState:UIControlStateNormal];
                break;
            case 8:
                [thumbButton setImage:[self CIFalseColor:_photoImage]forState:UIControlStateNormal];
                break;
            case 9:
                [thumbButton setImage:[self CIGaussianBlur:_photoImage]forState:UIControlStateNormal];
                break;
            case 10:
                [thumbButton setImage:[self CIGloom:_photoImage]forState:UIControlStateNormal];
                break;
            case 11:
                [thumbButton setImage:[self CIHatchedScreen:_photoImage]forState:UIControlStateNormal];
                break;
            case 12:
                [thumbButton setImage:[self CIHueAdjust:_photoImage]forState:UIControlStateNormal];
                break;
            case 13:
                [thumbButton setImage:[self CILineScreen:_photoImage]forState:UIControlStateNormal];
                break;
            case 14:
                [thumbButton setImage:[self CIPixellate:_photoImage]forState:UIControlStateNormal];
                break;
            case 15:
                [thumbButton setImage:[self filterImage:_photoImage]forState:UIControlStateNormal];
                break;
            case 16:
                [thumbButton setImage:[self sepiaTone:_photoImage]forState:UIControlStateNormal];
                break;
            case 17:
                [thumbButton setImage:[self CIToneCurve:_photoImage]forState:UIControlStateNormal];
                break;
            case 18:
                [thumbButton setImage:[self CIMaximumComponent:_photoImage] forState:UIControlStateNormal];
                break;
            case 19:
                [thumbButton setImage:[self CIWhitePointAdjust:_photoImage] forState:UIControlStateNormal];
                break;
            case 20:
                [thumbButton setImage:[self CIUnsharpMask:_photoImage] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        [self.scrollView addSubview:thumbButton];
    }
}

-(UIImage *)CITwirlDistortion : (UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *hueFilter = [CIFilter filterWithName:@"CITwirlDistortion"];
    [hueFilter setDefaults];
    [hueFilter setValue: inputImage forKey: @"inputImage"];
    [hueFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(150, 150)] forKey: @"inputCenter"];
    [hueFilter setValue:[NSNumber numberWithFloat:100] forKey:@"inputRadius"];
    [hueFilter setValue:[NSNumber numberWithFloat:3.14] forKey:@"inputAngle"];
    
    
    CIImage *outputImage = [hueFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
    
}
-(UIImage *)CIHueAdjust : (UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *hueFilter = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueFilter setDefaults];
    [hueFilter setValue: inputImage forKey: @"inputImage"];
    [hueFilter setValue: [NSNumber numberWithFloat: 3.0f] forKey: @"inputAngle"];
    
    CIImage *outputImage = [hueFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
    
}

-(UIImage *)sepiaTone : (UIImage *) image {
    
    CIImage *beginImage = [[CIImage alloc] initWithImage:
                           image];
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", @0.7, nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    return newImage;
    
    CGImageRelease(cgimg);
}

-(UIImage *)CIToneCurve : (UIImage*)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIToneCurve"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(0, 0)] forKey: @"inputPoint0"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(0.27, 0.25)] forKey: @"inputPoint1"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(0.5, 0.8)] forKey: @"inputPoint2"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(0.75, 1.0)] forKey: @"inputPoint3"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(10, 10)] forKey: @"inputPoint4"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CIWhitePointAdjust : (UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIWhitePointAdjust"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIColor colorWithString:@"255 0 187 1.0"] forKey:@"inputColor"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CIExposureAdjust : (UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *exposureAdjustFilter = [CIFilter filterWithName:@"CIExposureAdjust"];
    [exposureAdjustFilter setDefaults];
    [exposureAdjustFilter setValue: inputImage forKey: @"inputImage"];
    [exposureAdjustFilter setValue:[NSNumber numberWithFloat: 2.0f]
                            forKey:@"inputEV"];
    CIImage *outputImage = [exposureAdjustFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
    
}

-(UIImage *)CIColorInvert : (UIImage *)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIColorInvert"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
}

-(UIImage *)CIGloom  :(UIImage*)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIGloom"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[NSNumber numberWithFloat:20] forKey:@"inputRadius"];
    [invertFilter setValue:[NSNumber numberWithFloat:5] forKey:@"inputIntensity"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
}

-(UIImage *)CIColorMonochrome : (UIImage *)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIColor colorWithString:@"255 255 255 1.0"] forKey:@"inputColor"];
    [invertFilter setValue:[NSNumber numberWithFloat:3] forKey:@"inputIntensity"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
}

-(UIImage *)CIColorPosterize : (UIImage *)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIColorPosterize"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[NSNumber numberWithFloat:10] forKey:@"inputLevels"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CIHatchedScreen : (UIImage*)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIHatchedScreen"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue: [CIVector vectorWithCGPoint:CGPointMake(150, 150)] forKey: @"inputCenter"];
    [invertFilter setValue:[NSNumber numberWithFloat:0] forKey:@"inputAngle"];
    [invertFilter setValue:[NSNumber numberWithFloat:6.0] forKey:@"inputWidth"];
    [invertFilter setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputSharpness"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
}

-(UIImage *)CIColorMap : (UIImage*)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIColorMap"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:inputImage forKey:@"inputGradientImage"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
    
}

-(UIImage *)CIPixellate : (UIImage *) image{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIPixellate"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIVector vectorWithCGPoint:CGPointMake(150, 150)] forKey:@"inputCenter"];
    [invertFilter setValue:[NSNumber numberWithFloat:8] forKey:@"inputScale"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
    
}

-(UIImage *)CIBloom : (UIImage *)image{
    
    CIImage * inputImage = [[CIImage alloc]initWithImage:image];
    CIFilter * filter = [CIFilter filterWithName:@"CIBloom"];
    [filter setDefaults];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:10] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:1] forKey:@"inputIntensity"];
    CIImage *outputImage = [filter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
}

-(UIImage *)filterImage:(UIImage*) image {
    
    CIImage *rawImageData;
    rawImageData =[[CIImage alloc] initWithImage:image];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIDotScreen"];
    [filter setDefaults];
    
    [filter setValue:rawImageData forKey:@"inputImage"];
    
    [filter setValue:[NSNumber numberWithFloat:25.00]
              forKey:@"inputWidth"];
    
    [filter setValue:[NSNumber numberWithFloat:0.00]
              forKey:@"inputAngle"];
    
    [filter setValue:[NSNumber numberWithFloat:0.70]
              forKey:@"inputSharpness"];
    
    CIImage *filteredImageData = [filter valueForKey:@"outputImage"];
    
    UIImage *filteredImage = [UIImage imageWithCIImage:filteredImageData];
    
    return filteredImage;
}

-(UIImage *)CIFalseColor : (UIImage *) image{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIColor colorWithString:@"255 255 255 1.0"] forKey:@"inputColor0"];
    [invertFilter setValue:[CIColor colorWithString:@"0 0 0 0"] forKey:@"inputColor1"];
    //[invertFilter setValue:[NSNumber numberWithFloat:3] forKey:@"inputIntensity"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CIMaskToAlpha :(UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIMaskToAlpha"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CIGaussianBlur : (UIImage *)image{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[NSNumber numberWithFloat:5] forKey:@"inputRadius"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}

-(UIImage *)CICircularScreen : (UIImage *) image{
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CICircularScreen"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIVector vectorWithCGPoint:CGPointMake(150, 150)] forKey:@"inputCenter"];
    [invertFilter setValue:[NSNumber numberWithFloat:6] forKey:@"inputWidth"];
    [invertFilter setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputSharpness"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
}

-(UIImage *)CIMaximumComponent : (UIImage *)image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIMaximumComponent"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return  [UIImage imageWithCGImage:[context
                                       createCGImage:outputImage
                                       fromRect:outputImage.extent]];
    
}

-(UIImage *)CILineScreen : (UIImage *) image {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CILineScreen"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[CIVector vectorWithCGPoint:CGPointMake(150, 150)] forKey:@"inputCenter"];
    [invertFilter setValue:[NSNumber numberWithFloat:0] forKey:@"inputAngle"];
    [invertFilter setValue:[NSNumber numberWithFloat:6] forKey:@"inputWidth"];
    [invertFilter setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputSharpness"];
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
    
}


-(UIImage*)CIColorCube : (UIImage *)image{
    
    uint8_t color_cube_data[8*4] = {
        0, 0, 0, 1,
        1, 0, 0, 1,
        0, 1, 0, 1,
        1, 1, 0, 1,
        0, 0, 1, 1,
        1, 0, 1, 1,
        0, 1, 1, 1,
        1, 1, 1, 1
    };
    
    NSData * cube_data =[NSData dataWithBytes:color_cube_data length:8*4*sizeof(uint8_t)];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorCube"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2 forKey:@"inputCubeDimension"];
    [filter setValue:cube_data forKey:@"inputCubeData"];
    CIImage *outputImage = [filter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
}

-(UIImage *)createGrayCopy:(UIImage *)image
{
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, nil, kCGImageAlphaOnly);
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef mask = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *grayScaleImage = [UIImage imageWithCGImage:CGImageCreateWithMask(imageRef, mask) scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(mask);
    
    // Return the new grayscale image
    return grayScaleImage;
}

-(UIImage*)CIUnsharpMask : (UIImage*) image{
    CIImage *inputImage = [[CIImage alloc] initWithImage:
                           image];
    
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIUnsharpMask"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    [invertFilter setValue:[NSNumber numberWithFloat:2.50] forKey:@"inputRadius"];
    [invertFilter setValue:[NSNumber numberWithFloat:2.50] forKey:@"inputIntensity"];
    
    
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage:[context
                                      createCGImage:outputImage
                                      fromRect:outputImage.extent]];
}


#pragma mark - UIControl

-(void)buttonPressed : (id)sender {
    
    self.scrollView.hidden = YES;
    int buttonSender = (int)[sender tag];
    
    switch (buttonSender) {
        case 0:
            _photoImageView.image = _photoImage ;
            break;
        case 1:
            _photoImageView.image =[self CIBloom:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 2:
            _photoImageView.image =[self CICircularScreen:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 3:
            _photoImageView.image =[self CIColorInvert:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 4:
            _photoImageView.image =[self CIColorMap:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 5:
            _photoImageView.image =[self CIColorMonochrome:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 6:
            _photoImageView.image =[self CIColorPosterize:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            
            break;
        case 7:
            _photoImageView.image =[self CIExposureAdjust:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 8:
            _photoImageView.image =[self CIFalseColor:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 9:
            _photoImageView.image =[self CIGaussianBlur:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            
            break;
        case 10:
            _photoImageView.image =[self CIGloom:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 11:
            _photoImageView.image =[self CIHatchedScreen:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 12:
            _photoImageView.image =[self CIHueAdjust:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 13:
            _photoImageView.image =[self CILineScreen:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 14:
            _photoImageView.image =[self CIPixellate:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 15:
            _photoImageView.image =[self filterImage:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 16:
            _photoImageView.image = [self sepiaTone:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 17:
            _photoImageView.image = [self CIToneCurve:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 18:
            _photoImageView.image = [self CIMaximumComponent:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 19:
            _photoImageView.image = [self CIWhitePointAdjust:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case 20:
            _photoImageView.image = [self CIUnsharpMask:_photoImage];
            _photoImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
            
        default:
            break;
    }
}


- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sharePressed:(id)sender {
    
    SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [composeController setInitialText:@"I've just shared this"];
    
    if(self.photoImageView.image != nil)
    {
        [composeController addImage:self.photoImageView.image];
    }
    
    [composeController addURL: [NSURL URLWithString:@""]];
    
    [self presentViewController:composeController animated:YES completion:nil];
    
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        
        if (result == SLComposeViewControllerResultCancelled) {
    
            
        }else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"image shared successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    };
    composeController.completionHandler =myBlock;
}

- (IBAction)applyFilterPressed:(id)sender {
    
    [self imageFun];
    
    self.scrollView.hidden = NO;
}

@end

