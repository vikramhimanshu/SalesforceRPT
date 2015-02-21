//
//  Counter.h
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject

@property (nonatomic,readonly)  NSUInteger counter;

- (instancetype)initWithValue:(NSUInteger)value;

- (void)incrementCounter;
- (void)decrementCounter;
- (void)resetCounter;

@end
