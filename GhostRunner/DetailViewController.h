//
//  DetailViewController.h
//  GhostRunner
//
//  Created by Carlos Fernández López on 20/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//
/*The detailviewcontroller is the detail view where it is possible to set the name, location, date and track(peding of perform this last) of each track to persisten storage through core data. */

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UILabel *PickedDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (strong,nonatomic) NSString * locationtext;
@property (weak, nonatomic) IBOutlet UILabel *Location;

- (IBAction)SelectDate:(id)sender;
- (IBAction)BackButton:(id)sender;

@end
