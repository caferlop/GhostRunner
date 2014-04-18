//
//  OpenWeatherDataModel.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenWeatherDataModel : NSObject

@property (nonatomic) CGFloat tempCurrent;
@property (nonatomic) NSInteger  cloudCover;

-(void)getCurrent:(NSString*)Jquery;

@end
