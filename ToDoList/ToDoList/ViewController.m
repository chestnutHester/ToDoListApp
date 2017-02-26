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
@property(strong,nonatomic) NSString *toDoItemCellReuseIdentifier;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"To Do List"];
    
    //Create an array of all the ToDoItems
    _toDoList = [[NSMutableArray alloc] init];
    
    _toDoItemCellReuseIdentifier = @"ToDoItemCell";
    
    //Set the table view up for adding/removing cells
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:_toDoItemCellReuseIdentifier];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:_toDoItemCellReuseIdentifier];
    }
    cell.textLabel.text = _toDoList[indexPath.row];
    return cell;
}

- (IBAction)addButtonPress:(id)sender {
}

- (IBAction)saveButtonPress:(id)sender {
}
@end
