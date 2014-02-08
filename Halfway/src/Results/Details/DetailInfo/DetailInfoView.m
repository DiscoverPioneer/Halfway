//
//  DetailInfoView.m
//  Halfway
//
//  Created by Alex Koshy on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "DetailInfoView.h"
#import "Location.h"

@implementation DetailInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"DetailInfoView" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void) setLocation:(Location *)loc
{
    self.loc = loc;
    self.nameLabel.text = self.loc.name;
    self.street1Label.text = self.loc.street1;
    self.regionLabel.text = [self.loc formatRegionString];
    self.descriptionLabel.text = self.loc.description;
}

@end















