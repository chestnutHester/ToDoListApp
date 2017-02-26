//
//  ToDoItem.m
//  ToDoList
//
//  Created by Hester Corne on 26/02/2017.
//  Copyright © 2017 Hester Corne. All rights reserved.
//

#import "ToDoItem.h"
@interface ToDoItem()
@property(strong,nonatomic) NSString *name;
@property (nonatomic) BOOL complete;
@end

@implementation ToDoItem

-(ToDoItem*)init{
    self = [super init];
    _name = nil;
    _complete = NO;
    return self;
}

-(ToDoItem*)initWithDetails:(NSString *)name :(BOOL)complete{
    self = [super init];
    _name = name;
    _complete = complete;
    return self;
}

-(NSString*)getName{
    return _name;
}

-(BOOL)getComplete{
    return _complete;
}

-(void)setComplete:(BOOL)complete{
    _complete = complete;
}
@end
