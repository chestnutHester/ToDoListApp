//
//  ViewController.m
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import "ViewController.h"
#import "ToDoItem.h"

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
    
    //Create an array of all the ToDoItems
    _toDoList = [[NSMutableArray alloc] init];
    
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
    ToDoItem *currentItem = _toDoList[indexPath.row];
    cell.textLabel.text = [currentItem getName];
    
    //show a check mark if the item has been completed
    if([currentItem getComplete]){
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
    ToDoItem *currentItem = _toDoList[indexPath.row];
    [currentItem setComplete:![currentItem getComplete]];
    
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
                                     ToDoItem *newItem = [[ToDoItem alloc] initWithDetails:textField.text :NO];
                                     [_toDoList addObject:newItem];
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
    NSMutableArray *remainingToDoList = [[NSMutableArray alloc] init];
    for(ToDoItem *item in _toDoList){
        if(![item getComplete]){
            [remainingToDoList addObject:item];
        }
    }
    
    _toDoList = remainingToDoList;
    
    [_tableView reloadData];
}
@end
