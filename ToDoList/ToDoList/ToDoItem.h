//
//  ToDoItem.h
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
-(ToDoItem*)initWithDetails:(NSString*)name :(BOOL)complete;
-(NSString*)getName;
-(BOOL)getComplete;
@end
