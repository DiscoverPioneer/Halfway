//
//  HomeViewController.h
//  Halfway
//
//  Created by Phil Scarfi on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController{
    NSMutableData *responseData;

}

- (IBAction)didExecuteSearch:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
