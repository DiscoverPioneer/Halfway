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

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Location *loc;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *street1Label;
@property (strong, nonatomic) IBOutlet UILabel *regionLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;


@end
