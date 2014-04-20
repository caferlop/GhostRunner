//
//  WeatherView.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 18/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "WeatherView.h"
#import <QuartzCore/QuartzCore.h>



@implementation WeatherView
{
    //UIImageView * cloud;
    
}

+(WeatherView*)weatherView:(UIView*)view
{
    WeatherView * weatherView = [[WeatherView alloc]initWithFrame:view.bounds];
    [view addSubview:weatherView];
    view.userInteractionEnabled=NO;
    weatherView.opaque=NO;
    
    return weatherView;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
   
    CGRect viewRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    UIBezierPath * roundBorder = [UIBezierPath bezierPathWithRoundedRect:viewRect cornerRadius:10.0f];
    
    [[UIColor colorWithWhite:0.65 alpha:0.5]setFill];
    [roundBorder fill];
    

    //Drawing clouds with round corners and moving them. Adding a subview for the cloud with an image, and using layers properties of quarzt core to round it.
    //Way 1
    UIImage * cloud = [UIImage imageNamed:@"Cloud1.png"];
    [cloud drawAtPoint:CGPointMake(self.center.x-(cloud.size.width)/2, self.center.y-cloud.size.height/4)];
    
    //Way 2. It crahs in Imagelayer.contents...
    /*
    CALayer * Imagelayer = [CALayer alloc];
    Imagelayer.contents = (id)[UIImage imageNamed:@"Cloud1.png"].CGImage;
    [self.layer addSublayer:Imagelayer];
     */
    
  
    
   
}

/*
//-------------------------------------------------------------
#pragma mark Scaling image method
//-------------------------------------------------------------
-(UIImage*)imageWithiImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
 */
@end
