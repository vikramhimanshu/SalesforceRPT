//
//  ChartViewController.m
//  SalesforceRPT
//
//  Created by Himanshu on 2/20/15.
//  Copyright (c) 2015 Himanshu. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController () <UIWebViewDelegate>

@property (nonatomic) UIWebView *webview;
@property (nonatomic) NSString *htmlString;
@property (nonatomic) UIActivityIndicatorView *loader;

@end

@implementation ChartViewController

-(void)loadView
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"kChartViewTitle", nil);
    self.view = [self webview];
}

- (UIWebView *)webview
{
    if (_webview == nil) {
        CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
        _webview = [[UIWebView alloc] initWithFrame:rect];
        _webview.delegate = self;
    }
    return _webview;
}

- (void)loadHTMLString:(NSString *)string
{
    [self.webview loadHTMLString:string baseURL:nil];
}

- (NSString *)htmlStringWithChartData:(NSString *)data
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Chart" ofType:@"html"];
    self.htmlString = [NSString stringWithContentsOfFile:htmlFile
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
    
    NSString *h = [NSString stringWithFormat:@"%f",CGRectGetHeight(self.view.bounds)];
    NSString *w = [NSString stringWithFormat:@"%f",CGRectGetWidth(self.view.bounds)];
    self.htmlString = [_htmlString stringByReplacingOccurrencesOfString:@"$#height#$"
                                                             withString:h];
    self.htmlString = [_htmlString stringByReplacingOccurrencesOfString:@"$#width#$"
                                                             withString:w];

    return [self.htmlString stringByReplacingOccurrencesOfString:@"$##CHARTDATA##$"
                                                      withString:data];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.navigationItem.titleView = self.loader;
    [self.loader startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loader stopAnimating];
    self.navigationItem.titleView = nil;
    self.title = NSLocalizedString(@"kChartViewTitle", nil);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Char Load Error"
                                                    message:[error.userInfo description]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

-(UIActivityIndicatorView *)loader
{
    if (_loader == nil) {
        _loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loader.hidesWhenStopped = YES;
        [_loader stopAnimating];
    }
    return _loader;
}

@end
