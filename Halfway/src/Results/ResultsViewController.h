//
//  ResultsViewController.h
//  Halfway
//
//  Created by Alex Koshy on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSArray *resultsArray;

@property (strong, nonatomic) UISegmentedControl *displayOption;

@end
