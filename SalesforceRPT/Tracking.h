//
//  Tracking.h
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ClickEvent,
    ShakeEvent,
    LastValueEvent
} EventTypes;

@interface Tracking : NSObject

+(instancetype)sharedInstance;

- (NSUInteger)getRecentValue;
- (BOOL)saveRecentValue:(NSUInteger)value;

-(void)logEvent:(EventTypes)type withData:(NSDictionary *)payload;
- (BOOL)save;
- (NSArray *)getAllEvents;

- (NSDictionary *)payLoadWithValue:(NSUInteger)value;

@end
