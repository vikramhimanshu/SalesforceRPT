//
//  EventsLogTableViewController.m
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#define CELL_ID @"eventCell"

#import "EventsLogTableViewController.h"
#import "Tracking.h"

@interface EventsLogTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *eventsLog;
@property (nonatomic)  Tracking *tracking;

@end

@implementation EventsLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CELL_ID];
    
    self.eventsLog = [self.tracking getAllEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventsLog.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID
                                                            forIndexPath:indexPath];
    cell.detailTextLabel.text = [self eventNameForIndexPath:indexPath];
    cell.textLabel.text = [self displayValueForIndexPath:indexPath];
    return cell;
}

- (NSString *)eventNameForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.eventsLog objectAtIndex:indexPath.row];
    return [[event allKeys] firstObject];
}

- (NSString *)displayValueForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.eventsLog objectAtIndex:indexPath.row];
    NSDictionary *eventValue = [event valueForKey:[self eventNameForIndexPath:indexPath]];
    NSString *formatedValue = [NSString stringWithFormat:@"%@: %@",eventValue[@"value"],eventValue[@"timeStamp"]];
    return formatedValue;
}

-(Tracking *)tracking
{
    if (_tracking == nil) {
        _tracking = [Tracking sharedInstance];
    }
    return _tracking;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
