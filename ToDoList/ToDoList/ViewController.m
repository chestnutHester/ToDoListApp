//
//  ViewController.m
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import "ViewController.h"
//#import "ToDoItem.h"
#import "AppDelegate.h"

@interface ViewController ()
@property(strong,nonatomic) NSMutableArray *toDoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"To Do List"];
    
    //Set the tableView delegate and data source to allow for didSelectRow
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    //Load the to do list
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedContext = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    
    @try{
        NSArray *results = [managedContext executeFetchRequest:fetchRequest error:nil];
        _toDoList = [[NSMutableArray alloc] initWithArray:results];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        NSLog(@"List retreived");
    }
    
    //Set the table view up for adding/removing cells
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)_toDoList.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Cell"];
    }
    
    NSManagedObject *item = _toDoList[indexPath.row];
    cell.textLabel.text = [item valueForKey:@"name"];
    
    //show a check mark if the item has been completed
    if([[item valueForKey:@"completed"] isEqualToString:@"YES"]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    //deselect the row (otherwise it stays grey forever)
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //Toggle the complete property
    NSManagedObject *currentItem = _toDoList[indexPath.row];
    NSString *currentComplete = [currentItem valueForKey:@"completed"];
    if([currentComplete isEqualToString:@"NO"]){
        [currentItem setValue:@"YES" forKey:@"completed"];
    }
    else{
        [currentItem setValue:@"NO" forKey:@"completed"];
    }
    
    [tableView reloadData];
}

- (IBAction)addButtonPress:(id)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"New Item"
                                message:@"Enter the name of the new item"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *saveButton = [UIAlertAction
                                 actionWithTitle:@"Save"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     //Handle your yes please button action here
                                     UITextField *textField = alert.textFields[0];
                                     
                                     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                     NSManagedObjectContext *managedContext = appDelegate.persistentContainer.viewContext;
                                     NSManagedObject *item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:managedContext];
                                     [item setValue:textField.text forKey:@"name"];
                                     [item setValue:@"NO" forKey:@"completed"];
                                     
                                     @try{
                                         [managedContext save:nil];
                                         [_toDoList addObject:item];
                                     }
                                     @catch (NSException *exception) {
                                         NSLog(@"%@", exception.reason);
                                     }
                                     @finally {
                                         NSLog(@"Item Saved");
                                     }
                                     
                                    [_tableView reloadData];
                                 }];
    
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    [alert addAction:saveButton];
    [alert addAction:cancelButton];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"New Name";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)saveButtonPress:(id)sender {
    //Remove completed items
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedContext = appDelegate.persistentContainer.viewContext;
    NSMutableArray *completedItems = [[NSMutableArray alloc] init];
    for(int i=0; i<_toDoList.count; i++){
        NSManagedObject *item = _toDoList[i];
        if([[item valueForKey:@"completed"] isEqualToString:@"YES"]){
            [completedItems addObject:item];
        }
    }
    
    for(int i=0; i<completedItems.count; i++){
        NSManagedObject *item = completedItems[i];
        @try{
            [managedContext save:nil];
            [_toDoList removeObject:item];
            [managedContext deleteObject:item];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
        @finally {
            NSLog(@"Item deleted");
        }
    }
    
    [_tableView reloadData];

}
@end
