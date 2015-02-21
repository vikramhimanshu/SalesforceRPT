//
//  MasterViewController.m
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import "MasterViewController.h"
#import "EventsLogTableViewController.h"
#import "Counter.h"
#import "Tracking.h"

@interface MasterViewController ()

@property (nonatomic,retain)  UIButton *clickerButton;
@property (nonatomic,retain)  UILabel *counterLabel;

@property (nonatomic,retain) EventsLogTableViewController *eventsController;

@property (nonatomic,retain)  Counter *counterValue;
@property (nonatomic,retain)  Tracking *tracking;

@end

@implementation MasterViewController

-(void)dealloc
{
    [_clickerButton release];
    [_counterLabel release];
    [_eventsController release];
    [_counterValue release];
    [_tracking release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"kTitle", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(viewEventLog)];
    
    self.view = [self createMainView];
    [self.view addSubview:[self counterLabel]];
    [self.view addSubview:[self clickerButton]];
}

#pragma mark - Lazy loading properties

-(Counter *)counterValue
{
    if (_counterValue == nil) {
        _counterValue = [[Counter alloc] initWithValue:0];
    }
    return _counterValue;
}

-(Tracking *)tracking
{
    if (_tracking == nil) {
        _tracking = [Tracking sharedInstance];
    }
    return _tracking;
}

-(EventsLogTableViewController *)eventsController {
    if (_eventsController == nil) {
        _eventsController = [[EventsLogTableViewController alloc] init];
    }
    return _eventsController;
}

#pragma mark - UI

- (UIView *)createMainView
{
    CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
    UIView *view = [[[UIView alloc] initWithFrame:rect] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UILabel *)counterLabel {
    
    if (_counterLabel == nil) {
        CGRect frame = CGRectZero;
        frame.origin.x = 0;
        frame.origin.y = 50;
        frame.size.width = CGRectGetWidth(self.view.bounds);
        frame.size.height = frame.size.width;
        
        _counterLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
        [_counterLabel setFont:[UIFont systemFontOfSize:288.0]];
        _counterLabel.textAlignment = NSTextAlignmentCenter;
        _counterLabel.adjustsFontSizeToFitWidth = YES;
        _counterLabel.minimumScaleFactor = 0.1;
        _counterLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.tracking getRecentValue]];
    }
    
    return _counterLabel;
}

- (UIButton *)clickerButton
{
    if (_clickerButton == nil) {
        _clickerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_clickerButton addTarget:self
                           action:@selector(clickerClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_clickerButton setTitle:NSLocalizedString(@"kClickerTitle", nil)
                        forState:UIControlStateNormal];
        
        CGRect frame = _counterLabel.frame;
        frame.origin.x = 10;
        frame.origin.y = CGRectGetHeight(_counterLabel.frame)+_counterLabel.frame.origin.y;
        frame.size.width = 300;
        frame.size.height = 44;
        
        _clickerButton.frame = frame;
    }
    return _clickerButton;
}

#pragma mark - Actions

- (void)viewEventLog
{
    [self.navigationController pushViewController:self.eventsController
                                         animated:YES];
}

- (void)clickerClicked:(UIButton *)button
{
    [self.counterValue incrementCounter];
    [self updateCounterLabel];
    
    [self.tracking logEvent:ClickEvent
                   withData:[self.tracking payLoadWithValue:self.counterValue.counter]];
}

- (void)updateCounterLabel
{
    [self.tracking saveRecentValue:self.counterValue.counter];
    self.counterLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.counterValue.counter];
}



#pragma mark - ShakeEvent

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        [self.counterValue resetCounter];
        [self updateCounterLabel];
        [self.tracking logEvent:ShakeEvent
                       withData:[self.tracking payLoadWithValue:self.counterValue.counter]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self resignFirstResponder];
}

@end


