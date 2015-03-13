//
//  ListViewController.m
//  TheAssignment


#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    self.photoListView.delegate = self;
    self.photoListView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[self restClient] loadMetadata:@"/" withHash:@""];
    
    self.imageArray = [[NSMutableArray alloc]init];
    self.imageNameArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DBRestClientDelegate methods

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    
    if (metadata.isDirectory) {
        
        for (DBMetadata *file in metadata.contents) {
            
            [self.imageArray addObject:file.filename];
            NSData *pngData = [NSData dataWithContentsOfFile:file.icon];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
            NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",file.filename]]; //Add the file name
            [pngData writeToFile:filePath atomically:YES];
            
        }
    }
    
    for (int i = 0; i<self.imageArray.count; i++) {
        NSArray * pathComponents = [[self.imageArray objectAtIndex:i] componentsSeparatedByString:@"-"];
        [self.imageNameArray addObject:[pathComponents objectAtIndex:1]];
        
    }
    
    [self.photoListView reloadData];
}

- (void)restClient:(DBRestClient *)client

loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.backgroundColor = [UIColor clearColor];
        self.cellImageView = [[UIImageView alloc]init];
        self.cellImageView.tag = 1;
        self.cellImageView.frame = CGRectMake(10, 10, 60, 60);
        self.cellImageView.layer.borderWidth = 1;
        self.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
        [cell addSubview:self.cellImageView];
        
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.frame = CGRectMake(70, 10, 250, 60);
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.tag = 2;
        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.nameLabel.font = [UIFont fontWithName:@"Times New Roman" size:12];
        [cell addSubview:self.nameLabel];
    }
    else{
        self.nameLabel = (UILabel *)[cell viewWithTag:2];
        self.cellImageView = (UIImageView *) [cell viewWithTag:1];
    }
    
    
    self.nameLabel.text = [self.imageNameArray objectAtIndex:indexPath.row];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[self.imageArray objectAtIndex:indexPath.row]]];
    self.cellImageView.image = [UIImage imageWithContentsOfFile:filePath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.showPhotoView = [[ShowPhotoViewController alloc]initWithNibName:@"ShowPhotoViewController" bundle:nil];
    self.showPhotoView.imageName = [self.imageArray objectAtIndex:indexPath.row];
    [self presentViewController:self.showPhotoView animated:YES completion:nil];
    
}

#pragma mark - UIControl

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
