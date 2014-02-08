//
//  HomeViewController.h
//  Halfway
//
//  Created by Phil Scarfi on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController{
    NSMutableData *responseData;
    CLLocationManager *locationManager;

}

- (IBAction)didExecuteSearch:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UITextField *startAddress;
@property (strong, nonatomic) IBOutlet UITextField *friendAddress;
@property (strong, nonatomic) IBOutlet UISegmentedControl *radiusOutlet;
- (IBAction)radiusAction:(id)sender;
- (IBAction)advanceSearchAction:(id)sender;

@end
