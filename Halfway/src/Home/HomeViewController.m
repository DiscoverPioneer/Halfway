//
//  HomeViewController.m
//  Halfway
//
//  Created by Phil Scarfi on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//  

#import "HomeViewController.h"
#import "TestViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bypass:(id)sender {
    TestViewController *TVC =[[TestViewController alloc]init];
    [self presentViewController:TVC animated:YES completion:nil];
}
@end
