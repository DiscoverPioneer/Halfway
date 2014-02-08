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

#define METERS_PER_MILE 1609.344

@interface DetailViewController()
{
    /* Coordinates
    NSInteger y;
    NSInteger w;
    NSInteger h;
    // */
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Details";
        self.infoView = [[DetailInfoView alloc] init];
        
        /* Page Control and Coordinates
        self.pageControl = [[UIPageControl alloc] init];
        y = 0;
        w = 320;
        h = 264;
        // */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Configure PageControl
    self.pageControl.numberOfPages = self.resultsArray.count;
    self.pageControl.currentPage = self.selectedIndex;
    [self.pageControl updateCurrentPageDisplay];
    // */
    
    /* Correct Frames
    CGRect leftFrame    = CGRectMake(320*(self.selectedIndex-1), y, w, h);
    CGRect currentFrame = CGRectMake(320*(self.selectedIndex+0), y, w, h);
    CGRect rightFrame   = CGRectMake(320*(self.selectedIndex+1), y, w, h);
    // */
    
    /* Left Subview
    self.leftView = [[DetailInfoView alloc] init];
    self.leftView.frame = leftFrame;
    if (self.selectedIndex > 0)
        [self.leftView setLocation:[self.resultsArray objectAtIndex:self.selectedIndex-1]];
    [self.scrollView addSubview:self.leftView];
    // */
    
    // Current Subview
    self.currentView = [[DetailInfoView alloc] init];
    self.currentView.frame = CGRectMake(0, 0, 320, 264);
    [self.currentView setLocation:[self.resultsArray objectAtIndex:self.selectedIndex]];
    [self.scrollView addSubview:self.currentView];
    
    /* Right Subview
    self.rightView = [[DetailInfoView alloc] init];
    self.rightView.frame = rightFrame;
    if (self.selectedIndex > 0)
        [self.rightView setLocation:[self.resultsArray objectAtIndex:self.selectedIndex+1]];
    [self.scrollView addSubview:self.rightView];
    // */
    
    // Set Content Size (PageControl)
    //self.scrollView.contentSize = CGSizeMake(320*self.resultsArray.count, self.scrollView.frame.size.height);
    // Set Content Size
    //self.scrollView.contentSize = CGSizeMake(320,self.scrollView.frame.size.height);
    
    /* Scroll to view
    [self.scrollView scrollRectToVisible:currentFrame animated:YES];
    // */
}
- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentLoc.latitude;
    zoomLocation.longitude= self.currentLoc.longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D location;
    location.latitude = self.currentLoc.latitude;
	location.longitude = self.currentLoc.longitude;
    // Add the annotation to our map view
    MKPointAnnotation *newAnnotation =[[MKPointAnnotation alloc]init];
    newAnnotation.title = self.currentLoc.name;
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
    /* Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    
    // The upcoming page
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    // Replacement View
    DetailInfoView *nextView = [[DetailInfoView alloc] init];

    // Reconfigure views
    if (page < self.pageControl.currentPage) // Moving to the Left
    {
        //nextView.frame = rightFrame;
        nextView.frame = CGRectMake(320*(page-1), y, w, h);
        
        // [nextView setLocation:[self.resultsArray objectAtIndex:self.selectedIndex+1]];
        [nextView setLocation:[self.resultsArray objectAtIndex:page-1]];
        
        // set right = current
        self.rightLoc = self.currentLoc;
        // set current = left
        self.currentLoc = self.leftLoc;
        // set left = next
        self.leftLoc = nil;
        self.leftLoc = nextView.loc;
        
        // Remove right view from superview
        [self.rightView removeFromSuperview];
    }
    else // Moving to the Right
    {
        nextView.frame = CGRectMake(320*(page+1), y, w, h);
        [nextView setLocation:[self.resultsArray objectAtIndex:page+1]];
        
        // set left = current
        self.leftLoc = self.currentLoc;
        // set current = right
        self.currentLoc = self.rightLoc;
        // set right = next
        self.rightLoc = nil;
        self.rightLoc = nextView.loc;
        
        // Remove right view from superview
        [self.rightView removeFromSuperview];
    }
    
    [self.scrollView addSubview:nextView];
    
    // Reconfigure the actual current page last
    self.pageControl.currentPage = page;
    // */
}

- (IBAction)changePage:(UIPageControl *)sender
{
    /* update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    // */
}

@end












