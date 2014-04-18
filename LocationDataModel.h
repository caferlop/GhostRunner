//
//  LocationDataModel.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationDataModel : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray * arrayOfCoordinates;
@property (nonatomic,strong) CLLocation * Coordinates;
@property (nonatomic,strong) NSString * City;

-(void)startLocationManager;
-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;
-(NSString*)stringFromPlaceMark:(CLPlacemark*)thePlacemark;

@end
