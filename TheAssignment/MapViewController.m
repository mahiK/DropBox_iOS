//
//  MapViewController.m
//  TheAssignment


#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    self.mapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[self restClient] loadMetadata:@"/" withHash:@""];
    self.nameArray = [[NSMutableArray alloc]init];
    self.imageNameArray = [[NSMutableArray alloc]init];
    self.annotationArray = [[NSMutableArray alloc]init];
    self.longitudeArray = [[NSMutableArray alloc]init];
    self.latitudeArray = [[NSMutableArray alloc]init];
    
}

#pragma mark - DBRestClientDelegate methods

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    
    if (metadata.isDirectory) {
        for (DBMetadata *file in metadata.contents) {
            [self.nameArray addObject:file.filename];
        }
    }
    
    for (int i = 0; i<self.nameArray.count; i++) {
        
        NSArray * pathComponents = [[self.nameArray objectAtIndex:i] componentsSeparatedByString:@"-"];
        [self.imageNameArray addObject:[pathComponents objectAtIndex:1]];
        [self.longitudeArray addObject:[pathComponents objectAtIndex:2]];
        [self.latitudeArray addObject:[pathComponents objectAtIndex:3]];
    }
    
    for (int i= 0; i<self.nameArray.count; i++) {
        
        CLLocationCoordinate2D coord;
        coord.latitude = [[self.latitudeArray objectAtIndex:i]doubleValue];
        coord.longitude = [[self.longitudeArray objectAtIndex:i]doubleValue];
        
        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:[self.imageNameArray objectAtIndex:i] AndCoordinate:coord];
        [self.annotationArray addObject:annotation];
    }

    [self.mapView addAnnotations:self.annotationArray];
    
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

