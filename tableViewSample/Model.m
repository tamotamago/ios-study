//
//  Model.m
//  tableViewSample
//
//  Created by 武田 祐一 on 12/11/02.
//
//

#import "Model.h"

@interface Model ()
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation Model

- (id)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)addEntry:(NSDictionary *)entry
{
    [_array addObject:entry];
}

- (NSDictionary *)entryAtIndex:(NSInteger)index
{
    return _array[index];
}

- (NSInteger)count
{
    return _array.count;
}

- (void)fetchData
{
    NSURL *url = [NSURL URLWithString:@"http://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {

        if (error) {
            [self.delegate Model:self didFinishLoadingWithError:error];
            return ;
        }

        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];

        for (NSDictionary *entry in json[@"items"]) {
            [_array addObject:entry];
        }

        if (jsonError) {
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }

        [self.delegate Model:self didFinishLoadingWithError:jsonError];

    }];


}


#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row][@"title"];
    return cell;
}



@end
