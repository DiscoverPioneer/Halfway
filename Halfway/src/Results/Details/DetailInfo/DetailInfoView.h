//
//  DetailInfoView.h
//  Halfway
//
//  Created by Alex Koshy on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;

@interface DetailInfoView : UIView

@property (strong, nonatomic) Location *loc;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *street1Label;
@property (strong, nonatomic) IBOutlet UILabel *regionLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

- (void) setLocation:(Location *)loc;

@end
