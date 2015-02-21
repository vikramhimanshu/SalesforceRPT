//
//  Tracking.m
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import "Tracking.h"

@interface Tracking ()

@property (nonatomic,strong) NSMutableArray *eventsLog;
@property (nonatomic,strong) NSUserDefaults *userDefaults;

@end

@implementation Tracking

+(instancetype)sharedInstance
{
    static id _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Tracking alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        
        self.eventsLog = [[self getAllEvents] mutableCopy];
        if (self.eventsLog == nil) {
            self.eventsLog = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(void)logEvent:(EventTypes)type withData:(NSDictionary *)payload
{
    if (!payload) {
        return;
    }
    switch (type) {
        case ClickEvent:
            [self.eventsLog addObject:[self clickEventWithPayLoad:payload]];
            break;
        case ShakeEvent:
            [self.eventsLog addObject:[self shakeEventWithPayLoad:payload]];
            break;
        case LastValueEvent:
            [self.eventsLog addObject:[self shakeEventWithPayLoad:payload]];
            break;
    }
    [self save];
}

- (NSArray *)getAllEvents
{
    NSArray *returnVal = [self.userDefaults objectForKey:@"kEvents"];
    return returnVal;
}

- (BOOL)save
{
    [self.userDefaults setObject:self.eventsLog
                          forKey:@"kEvents"];
    return [self.userDefaults synchronize];
}

- (NSUInteger)getRecentValue {
    return [self.userDefaults integerForKey:@"kReecntValue"];
}

- (BOOL)saveRecentValue:(NSUInteger)value
{
    [self.userDefaults setInteger:value forKey:@"kReecntValue"];
    return [self.userDefaults synchronize];
}

- (NSDictionary *)payLoadWithValue:(NSUInteger)value
{
    return @{
             @"value":@(value),
             @"timeStamp":[NSDate date]
             };
}

- (NSDictionary *)lastValueEventWithPayLoad:(NSDictionary *)payload
{
    return @{@"lastValue":payload};
}

- (NSDictionary *)clickEventWithPayLoad:(NSDictionary *)payload
{
    return @{@"clickEvent":payload};
}

- (NSDictionary *)shakeEventWithPayLoad:(NSDictionary *)payload
{
    return @{@"shakeEvent":payload};
}

@end
