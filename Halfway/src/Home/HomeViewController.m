//
//  HomeViewController.m
//  Halfway
//
//  Created by Phil Scarfi on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//  

#import "HomeViewController.h"
#import "ResultsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Halfway";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)didExecuteSearch:(UIButton *)sender
{
    
    //Make API Call
    //Show Activity Indicator
    NSURL *myURL = [NSURL URLWithString:@"http://api.tripadvisor.com/api/partner/1.0/map/30.26532,-97.73852/restaurants?key=92C34F58BB4F4E03894F5D171B79857E&limit=10"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSURLConnection *connection;
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.activity startAnimating];
    self.view.userInteractionEnabled=NO;
    
}


#pragma mark CONNECTION DELEGATE
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.view.userInteractionEnabled=YES;
    [self.activity stopAnimating];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Whoops" message:@"Sorry, couldnt seem to get a response. Please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.view.userInteractionEnabled=YES;
    [self.activity stopAnimating];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray *results = [json objectForKey:@"data"];
    for (NSDictionary *dict in results) {
        NSLog(@"Name= %@",[dict objectForKey:@"name"]);
    }
    
    //Go to results page
    ResultsViewController *rvc = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
    [rvc setResultsArray:results];
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

















