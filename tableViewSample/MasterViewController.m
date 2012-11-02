//
//  MasterViewController.m
//  tableViewSample
//
//  Created by 武田 祐一 on 2012/11/01.
//
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    Model *_model;
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
    _model = [[Model alloc] init];
    _model.delegate = self;
    [(UITableView *)self.view setDelegate:_model];
    [(UITableView *)self.view setDataSource:_model];
    [_model fetchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = [_model entryAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)Model:(Model *)model didFinishLoadingWithError:(NSError *)error
{
    if (error) {
        NSLog(@"%@",error);
        return;
    }

    [self.tableView reloadData];
}

@end
