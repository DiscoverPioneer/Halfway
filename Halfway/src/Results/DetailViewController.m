//
//  DetailViewController.m
//  Halfway
//
//  Created by Phil Scarfi on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "DetailViewController.h"
#import "Location.h"
#import "DetailInfoView.h"
#import "OWActivityViewController.h"

#define METERS_PER_MILE 1609.344

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Details";
        self.infoView = [[DetailInfoView alloc] init];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(shareAction)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.infoView.nameLabel.text = self.loc.name;
    self.infoView.street1Label.text = self.loc.street1;
    self.infoView.regionLabel.text = [self.loc formatRegionString];
    
    @try{
        self.infoView.descriptionLabel.text = self.loc.description;
    }
    @catch (NSException *exception) {
        self.infoView.descriptionLabel.text=@"No Description Available";
    }
    @finally {
    [self.infoView.descriptionLabel sizeToFit];

    
    // Initialize Scroll View
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.scrollView addSubview:subview];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
    
    //self.infoView = [[[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil] objectAtIndex:0];
    [self.scrollView addSubview:self.infoView];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.loc.latitude;
    zoomLocation.longitude= self.loc.longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D location;
    location.latitude = self.loc.latitude;
	location.longitude = self.loc.longitude;
    // Add the annotation to our map view
    MKPointAnnotation *newAnnotation =[[MKPointAnnotation alloc]init];
    newAnnotation.title = self.loc.name;
    newAnnotation.coordinate = location;
	[self.mapView addAnnotation:newAnnotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)changePage:(UIPageControl *)sender
{
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}


-(void)shareAction{
    // Prepare activities
    //
    OWTwitterActivity *twitterActivity = [[OWTwitterActivity alloc] init];
    OWMailActivity *mailActivity = [[OWMailActivity alloc] init];
    //OWSafariActivity *safariActivity = [[OWSafariActivity alloc] init];
    //OWSaveToCameraRollActivity *saveToCameraRollActivity = [[OWSaveToCameraRollActivity alloc] init];
    //OWMapsActivity *mapsActivity = [[OWMapsActivity alloc] init];
    //OWPrintActivity *printActivity = [[OWPrintActivity alloc] init];
    //OWCopyActivity *copyActivity = [[OWCopyActivity alloc] init];
    OWFacebookActivity *facebookActivity =[[OWFacebookActivity alloc] init];
    //OWMessageActivity *messageActivity = [[OWMessageActivity alloc] init];
    // Create some custom activity
    //
    OWActivity *customActivity;
    customActivity= [[OWActivity alloc] initWithTitle:@"Share"
                                                             image:[UIImage imageNamed:@"OWActivityViewController.bundle/Icon_Custom"]
                                                       actionBlock:^(OWActivity *activity, OWActivityViewController *activityViewController) {
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               NSLog(@"Info: %@", activityViewController.userInfo);
                                                           }];
                                                       }];
    
    // Compile activities into an array, we will pass that array to
    // OWActivityViewController on the next step
    //
    
    NSMutableArray *activities = [NSMutableArray arrayWithObject:mailActivity];
    
    // For some device may not support message (ie, Simulator and iPod Touch).
    // There is a bug in the Simulator when you configured iMessage under OS X,
    // for detailed information, refer to: http://stackoverflow.com/questions/9349381/mfmessagecomposeviewcontroller-on-simulator-cansendtext
    if ([MFMessageComposeViewController canSendText]) {
        OWMessageActivity *messageActivity = [[OWMessageActivity alloc] init];
        [activities addObject:messageActivity];
    }
    
    [activities addObjectsFromArray:@[facebookActivity, twitterActivity]];
    
    
    //[activities addObjectsFromArray:@[
                                      //safariActivity, mapsActivity, printActivity, copyActivity, customActivity]];
    
    
    NSString *string = [NSString stringWithFormat:@"Check out this HotSpot to meetup! %@\n%@, %@",self.loc.name,self.loc.street1,self.infoView.regionLabel.text];
    
    // Create OWActivityViewController controller and assign data source
    //
    OWActivityViewController *activityViewController = [[OWActivityViewController alloc] initWithViewController:self activities:activities];
    activityViewController.userInfo = @{
                                        @"text": string,
                                        @"coordinate": @{@"latitude": @(self.loc.latitude), @"longitude": @(self.loc.longitude)}
                                        };
    
    [activityViewController presentFromRootViewController];
}
@end












