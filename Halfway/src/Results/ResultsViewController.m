//
//  ResultsViewController.m
//  Halfway
//
//  Created by Alex Koshy on 2/7/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "ResultsViewController.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "Location.h"
#import "ResultsCell.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Create Nav Bar Segmented Control
        self.displayOption = [self makeSegmentedControl];
        
        // Create and Display TableView
        self.tableView = [self makeTableView];
        [self.view addSubview:self.tableView];
        
        // Create MapView
        self.mapView = [self makeMapView];
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

# pragma mark SegmentedControl

- (UISegmentedControl *)makeSegmentedControl
{
    UISegmentedControl *displayOption = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"List", @"Map", nil]];
    [displayOption setSelectedSegmentIndex:0];
    [displayOption sizeToFit];
    self.navigationItem.titleView = displayOption;
    [displayOption addTarget:self
                      action:@selector(switchToDisplayMode)
            forControlEvents:UIControlEventValueChanged];
    
    return displayOption;
}

- (void)switchToDisplayMode
{
    // Method to switch to the selected segments interpreted display mode.
    
    // Set desired view
    if ([self.displayOption selectedSegmentIndex] == 1)
    {
        // Currently displaying TableView
        // Switch to Map View
        NSLog(@"Switch to Map");
        [self.tableView removeFromSuperview];
        [self.view addSubview:self.mapView];
    }
    else
    {
        // Currently displaying Map View
        // Switch to TableView
        NSLog(@"Switch to Table");
        [self.mapView removeFromSuperview];
        [self.view addSubview:self.tableView];
    }
}

# pragma mark Table View

-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resultsCellIdentifier = @"ResultsCellIdentifier";
    
    ResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:resultsCellIdentifier];
    
    if (cell == nil) {
        //cell = [[ResultsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resultsCellIdentifier];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ResultsCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ResultsCell class]])
            {
                cell = (ResultsCell *)currentObject;
                break;
            }
        }
    }
    
    Location *loc = [self.resultsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = loc.name;
    cell.street1Label.text = loc.street1;
    cell.regionLabel.text = [loc formatRegionString];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    DetailViewController *DVC = [[DetailViewController alloc]init];
    DVC.loc = [self.resultsArray objectAtIndex:indexPath.row];
    DVC.resultsArray = self.resultsArray;
    
    [self.navigationController pushViewController:DVC animated:YES];
}

# pragma mark Map View

-(MKMapView *)makeMapView
{
    return [[MKMapView alloc] initWithFrame:self.view.frame];
}

@end





















