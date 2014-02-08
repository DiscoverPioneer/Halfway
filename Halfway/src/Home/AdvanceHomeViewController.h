//
//  AdvanceHomeViewController.h
//  Halfway
//
//  Created by Phil Scarfi on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceHomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlOutlet;
- (IBAction)segmentedControlAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)searchAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *startTextField;
@property (strong, nonatomic) IBOutlet UITextField *othersTextField;

@end
