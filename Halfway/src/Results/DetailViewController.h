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
@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property NSString *detailString;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property float lat;
@property float lon;
@end
