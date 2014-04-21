//
//  DetailViewController.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 20/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "DetailViewController.h"
#import "TableViewStoryAppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.Name.delegate=self;
  
    self.Location.text=self.locationtext;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectDate:(id)sender {
    
    NSLocale * locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en ES"];
    
    NSDate * pickerDate = [self.DatePicker date];
    NSString * selectionString = [[NSString alloc]initWithFormat:@"%@",[pickerDate descriptionWithLocale:locale]];
    
    self.DateLabel.text = selectionString;
    
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
}
//-------------------------------------------------------------------
#pragma mark Performing Core Data Context and Object Creation
//-------------------------------------------------------------------

//-------------------------------------------------------------------
#pragma mark UITextfield delegate method
//-------------------------------------------------------------------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.Name )
    {
    [textField resignFirstResponder];
    }
   
    return YES;
}

//------------------------------------------------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
