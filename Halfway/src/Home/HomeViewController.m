//
//  HomeViewController.m
//  Halfway
//
//  Created by Phil Scarfi on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//  

#import "HomeViewController.h"
#import "ResultsViewController.h"
#import "Location.h"
#import "AdvanceHomeViewController.h"

@interface HomeViewController (){
    NSString *lat1;
    NSString *lon1;
    NSString *lat2;
    NSString *lon2;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"HotSpot";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Make Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // Best
    [locationManager startUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locationManager.location completionHandler:^(NSArray *placemarks, NSError *error){
        if(placemarks.count){
            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
            NSString *string=[NSString stringWithFormat:@"%@ %@, %@ %@ ",[dictionary valueForKey:@"Street"],[dictionary valueForKey:@"City"],[dictionary valueForKey:@"State"],[dictionary valueForKey:@"ZIP"]];
            self.startAddress.text =string;
            NSLog(@"HERE:%@",string);
        }
        
    }];
    
}
- (IBAction)didExecuteSearch:(UIButton *)sender
{
    
    if(![self.startAddress.text isEqualToString:@""]&&![self.startAddress.text isEqualToString:@"Enter a city or address"] && ![self.friendAddress.text isEqualToString:@""]&& ![self.friendAddress.text isEqualToString:@"Enter a city or address"]){
    //Make API Call
    //Show Activity Indicator
        [self geocodeRequest];
    }
    //Make sure all fields are filled in!!
    else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Whoops" message:@"Make Sure you fill in all the fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
}
-(void)geocodeRequest{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.startAddress.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if([placemarks count]){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            lat1 = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
            lon1 = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            [geocoder geocodeAddressString:self.friendAddress.text completionHandler:^(NSArray *placemarks, NSError *error) {
                //Do Something
                if([placemarks count]){
                    CLPlacemark *placemark = [placemarks objectAtIndex:0];
                    lat2 = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
                    lon2 = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
                    //Were good to go
                    [self makeRequest];
                }
                else{
                    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Whoops" message:@"Check the other person's address. Try to include street, city, state, & zip code." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
        else{
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Whoops" message:@"Check your address. Try to include street, city, state, & zip code." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];//Out
}
-(void)makeRequest{
    float lat1float = [lat1 floatValue];
    float lon1float = [lon1 floatValue];
    float lat2float = [lat2 floatValue];
    float lon2float = [lon2 floatValue];
    //Calculate midpoint coordinate
    float midlat = (lat1float + lat2float)/2;
    float midlon = (lon1float + lon2float)/2;
    NSString *urlString = [NSString stringWithFormat:@"http://api.tripadvisor.com/api/partner/1.0/map/%f,%f/restaurants?key=92C34F58BB4F4E03894F5D171B79857E&limit=10",midlat,midlon];
    NSURL *myURL = [NSURL URLWithString:urlString];
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
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //Go to results page
    ResultsViewController *rvc = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
    [rvc setResultsArray:[self makeResultsArrayFromData:[json objectForKey:@"data"]]];
    rvc.lat1 = [lat1 floatValue];
    rvc.lon1 = [lon1 floatValue];
    rvc.lat2 = [lat2 floatValue];
    rvc.lon2 = [lon2 floatValue];
    
    rvc.midlat =(rvc.lat1 + rvc.lat2)/2;
    rvc.midlon = (rvc.lon1 + rvc.lon1)/2;
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFielsShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)radiusAction:(id)sender {
    
}

- (IBAction)advanceSearchAction:(id)sender {
    AdvanceHomeViewController *AVC = [[AdvanceHomeViewController alloc]init];
    [self.navigationController pushViewController:AVC animated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (NSArray *)makeResultsArrayFromData:(NSArray *)data
{
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in data) {
        Location *loc = [[Location alloc] initWithDictionary:dict];
        [locations addObject:loc];
    }
    
    return locations;
}

@end

















