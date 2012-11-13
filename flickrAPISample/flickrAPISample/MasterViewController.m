//
//  MasterViewController.m
//  flickrAPISample
//
//  Created by 武田 祐一 on 12/11/09.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "CustomCell.h"

@interface MasterViewController ()
@property (nonatomic, strong) Model *model; // Model層へ書き出し
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.model = [[Model alloc] init]; // Modelの初期化
    self.model.delegate = self; // delegateによって通知される先をselfに
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.model fetchData]; // modelのデータ読み込みを開始。結果はdelegateで通知される

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    NSDictionary *entry = self.model.entries[indexPath.row];
    ((CustomCell*)cell).title = entry[@"title"];
    ((CustomCell*)cell).imageURLString = entry[@"media"][@"m"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.model.entries[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - model delegate

// Modelがデータをfetchしたあと、このメソッドが呼ばれます
- (void)modelDidFinishLoading:(Model *)model WithError:(NSError *)error
{
    if (error) {
        NSLog(@"error");
    }
    [self.tableView reloadData];
}


@end
