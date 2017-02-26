//
//  ViewController.h
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addButtonPress:(id)sender;
- (IBAction)saveButtonPress:(id)sender;



@end

