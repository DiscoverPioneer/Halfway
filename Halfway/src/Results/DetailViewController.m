//
//  DetailViewController.m
//  Halfway
//
//  Created by Phil Scarfi on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "DetailViewController.h"
#import "Location.h"
 
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = self.loc.name;
    self.street1Label.text = self.loc.street1;
    self.regionLabel.text = [self.loc formatRegionString];
    self.descriptionLabel.text = self.loc.description;
    [self.descriptionLabel sizeToFit];
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
	[self.mapView addAnnotation:newAnnotation];}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
