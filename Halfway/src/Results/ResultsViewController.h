//
//  ResultsViewController.h
//  Halfway
//
//  Created by Alex Koshy on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSArray *resultsArray;

@property (strong, nonatomic) UISegmentedControl *displayOption;

@property float lat1;
@property float lon1;
@property float lat2;
@property float lon2;
@property float midlat;
@property float midlon;

@end
