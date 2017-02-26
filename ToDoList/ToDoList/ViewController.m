//
//  ViewController.m
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic) NSMutableArray *toDoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"To Do List"];
    
    //Create an array of all the ToDoItems
    _toDoList = [[NSMutableArray alloc] init];
    
    //Set the table view up for adding/removing cells
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger*)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger*)_toDoList.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _toDoList[indexPath.row];
    return cell;
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
                                     [_toDoList addObject:textField.text];
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
}
@end
