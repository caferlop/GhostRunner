//
//  SavedTracksViewController.m
//  GhostRunner
//
//  Created by Carlos Fernández López on 21/04/14.
//  Copyright (c) 2014 Carlos Fernández López. All rights reserved.
//

#import "SavedTracksViewController.h"
#import "TableViewStoryAppDelegate.h"
#import "CellViewCell.h"

@interface SavedTracksViewController ()

@end

@implementation SavedTracksViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getObjectFromCoreData];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
 NSLog(@"Number of matching objects:%i",[self.matchingobjects count]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------
#pragma mark Performing Core Data Context and retreiving Object
//-------------------------------------------------------------------
-(void)getObjectFromCoreData
{
    TableViewStoryAppDelegate * Delegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext * context = [Delegate managedObjectContext];
    
    NSEntityDescription * EntityDescription = [NSEntityDescription entityForName:@"Track" inManagedObjectContext:context];
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    [request setEntity:EntityDescription];
    
    NSError * error;
    
    self.matchingobjects = [context executeFetchRequest:request error:&error];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    
    return [self.matchingobjects count];
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TrackCell";
    CellViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath row];
    
    cell.Nombre.text = [self.matchingobjects valueForKey:@"name"][row];
    cell.Locality.text = [self.matchingobjects valueForKey:@"location"][row];
    cell.Date.text = [self.matchingobjects valueForKey:@"date"][row];
    
    
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"BackToMapVIew" sender:nil];
    NSLog(@"Accessory tapped");
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
