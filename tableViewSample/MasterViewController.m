//
//  MasterViewController.m
//  tableViewSample
//
//  Created by 武田 祐一 on 2012/11/01.
//
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Model.h"
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
    [(UITableView *)self.view setDelegate:_model];
    [(UITableView *)self.view setDataSource:_model];

	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {

        NSError *er = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&er];

        for (NSDictionary *entry in jsonDict[@"items"]) {
            [_model addEntry:entry];
        }
        NSLog(@"error : %@", er);
        [(UITableView *)self.view reloadData];
    }];

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

@end
