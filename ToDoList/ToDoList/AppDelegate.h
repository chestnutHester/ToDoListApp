//
//  AppDelegate.h
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

