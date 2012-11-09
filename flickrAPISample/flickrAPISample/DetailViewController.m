//
//  DetailViewController.m
//  flickrAPISample
//
//  Created by 武田 祐一 on 12/11/09.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSURL *url = [NSURL URLWithString:_detailItem[@"link"]]; // 受信したエントリーの中のURL部分
        [_webView loadRequest:[NSURLRequest requestWithURL:url]]; // webViewのロード開始
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - UIWebViewDelegate -

// リクエストを読み込むかどうかをハンドリングする
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

// リクエストが読み込まれなかった時に呼ばれる
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

// リクエストが読み込み終わった時に呼ばれる
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

// リクエストが読み込みを開始したら呼ばれる
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}


@end
