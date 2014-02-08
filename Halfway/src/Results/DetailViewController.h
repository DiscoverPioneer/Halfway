//
//  DetailViewController.h
//  Halfway
//
//  Created by Phil Scarfi on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class Location;
@class DetailInfoView;

@interface DetailViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *resultsArray;

@property (strong, nonatomic) Location *loc;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) DetailInfoView *infoView;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(UIPageControl *)sender;

@end
