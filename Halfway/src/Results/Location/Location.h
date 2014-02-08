//
//  Location.h
//  Halfway
//
//  Created by Alex Koshy on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *street1;
@property (strong, nonatomic) NSString *street2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zipCode;

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

// Initializer
- (Location *)initWithDictionary:(NSDictionary *)dictionary;

// Methods
- (NSString *)formatRegionString;

@end
