//
//  CameraViewController.m
//  TheAssignment


#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        [self.locationManager performSelector:@selector(requestAlwaysAuthorization) withObject:self];
        [self.locationManager performSelector:@selector(requestWhenInUseAuthorization) withObject:self];
    }
    self.geocoder = [[CLGeocoder alloc] init];
    
    
    self.spinner = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    self.backgroundView.hidden = YES;
    [self.view addSubview:self.backgroundView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIControl

- (IBAction)takePhotoButtonPressed:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:picker animated:YES completion:^{}];
            }];
        }
        else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"No camera on this device!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)uploadPhotoButtonPressed:(id)sender {
    
    if(self.cameraImage != nil)
    {
        self.backgroundView.hidden = NO;
        self.spinner.frame = CGRectMake(50, 110, 200, 200);
        [self.view addSubview:self.spinner];
        [self.view bringSubviewToFront:self.spinner];
        self.spinner.hidden = NO;
        
        [self.spinner startAnimating];
        
        
        NSData *data = UIImageJPEGRepresentation(self.cameraImage, 1);
        NSString *filename = [NSString stringWithFormat:@"%d-%@-%f-%f.jpg",arc4random(),self.cityName,self.longitude,self.latitude];
        NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *localPath = [localDir stringByAppendingPathComponent:filename];
        [data writeToFile:localPath atomically:YES];
        NSString *destDir = @"/";
        [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:localPath];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Please capture image first" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)showListViewPressed:(id)sender {
    
    self.listView = [[ListViewController alloc]initWithNibName:@"ListViewController" bundle:nil];
    [self presentViewController:self.listView animated:YES completion:nil];
}

- (IBAction)showMapPressed:(id)sender {
    
    self.mapView = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    [self presentViewController:self.mapView animated:YES completion:nil];
}


#pragma mark - CLLocationManager methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.latitude = currentLocation.coordinate.latitude;
        self.longitude = currentLocation.coordinate.longitude;
        NSLog(@"latitude - %f , longitude - %f",self.latitude,self.longitude);
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    self.latitude = currentLocation.coordinate.latitude;
    self.longitude = currentLocation.coordinate.longitude;
    
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            self.cityName = [NSString stringWithFormat:@"%@",
                             self.placemark.thoroughfare];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}

#pragma mark UIImagePickerControllerDelgate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    self.cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.photoView.image = self.cameraImage;
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.photoView.hidden = YES;
    
}


#pragma mark - DBRestClientDelegate methods

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    self.backgroundView.hidden = YES;
    self.spinner.hidden = YES;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"File uploaded successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    self.backgroundView.hidden = YES;
    self.spinner.hidden = YES;
    NSLog(@"File upload failed with error: %@", error);
}
@end
