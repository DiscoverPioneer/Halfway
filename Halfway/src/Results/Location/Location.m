//
//  Location.m
//  Halfway
//
//  Created by Alex Koshy on 2/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "Location.h"

@implementation Location

- (Location *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.name = [dictionary objectForKey:@"name"];
        self.description = [dictionary objectForKey:@"description"];
        
        NSDictionary *address = [dictionary objectForKey:@"address_obj"];
        self.street1 = [address objectForKey:@"street1"];
        self.street2 = [address objectForKey:@"street2"];
        self.city = [address objectForKey:@"city"];
        self.state = [address objectForKey:@"state"];
        self.zipCode = [address objectForKey:@"postalcode"];
        
        self.latitude = [[dictionary objectForKey:@"latitude"] floatValue];
        self.longitude = [[dictionary objectForKey:@"longitude"] floatValue];
    }
    return self;
}

- (NSString *)formatRegionString
{
    //NSString *address = [NSString stringWithFormat:@"%@ %@ , %@ %@",self.street1,self.city,self.state,self.zipCode];
    //NSString *string = [NSString stringWithFormat:@"Name:\n%@\nLocation:\n%@\n\n%@",self.name,address,self.description];
    
    
    return [NSString stringWithFormat:@"%@, %@ %@",self.city,self.state,self.zipCode];
    
}

@end














