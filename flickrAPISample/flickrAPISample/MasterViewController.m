//
//  MasterViewController.m
//  flickrAPISample
//
//  Created by 武田 祐一 on 12/11/09.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // データのフェッチここから。起動時のエントリポイント的な場所です

    // URLの文字列からNSURLインスタンスを生成します。
    NSURL *url = [NSURL URLWithString:@"http://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"];

    // 次に URLRequestを生成します
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // URLRequestを突っ込むためのキューを用意します
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 非同期にリクエストを実行します。
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {

        NSError *jsonError = nil;

        // APIレスポンスがjsonで返ってくるので、シリアライズする
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        NSLog(@"%@", json);

    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
