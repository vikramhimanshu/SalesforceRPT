//
//  ChartViewController.h
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartViewController : UIViewController

- (void)loadHTMLString:(NSString *)string;
- (NSString *)htmlStringWithChartData:(NSString *)data;

@end
