//
//  Counter.m
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import "Counter.h"

@interface Counter ()

@property (nonatomic,readwrite)  NSUInteger counter;

@end

@implementation Counter

- (instancetype)initWithValue:(NSUInteger)value
{
    self = [super init];
    if (self) {
        self.counter = value;
    }
    return self;
}

-(void)incrementCounter
{
    self.counter++;
}

-(void)decrementCounter
{
    self.counter--;
}

-(void)resetCounter
{
    self.counter = 0;
}

@end
