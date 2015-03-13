//
//  LogInViewController.m
//  TheAssignment


#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UIControl
- (IBAction)logInWithDropboxButtonPressed:(id)sender {
    [[DBSession sharedSession] linkFromController:self];
    
    
}

#pragma mark - DBRestClientDelegate methods

- (DBRestClient *)restClient {
    if (!self.client) {
        self.client = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.client.delegate = self;
    }
    return self.client;
}

- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info{
    [[self restClient] loadMetadata:@"/"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
