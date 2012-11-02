//
//  Model.h
//  tableViewSample
//
//  Created by 武田 祐一 on 12/11/02.
//
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate;


@interface Model : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)addEntry:(NSDictionary *)entry;
- (NSDictionary *)entryAtIndex:(NSInteger)index;
- (NSInteger)count;
- (void)fetchData;

@property (nonatomic, weak) id<ModelDelegate> delegate;

@end


@protocol ModelDelegate <NSObject>

-(void)Model:(Model *)model didFinishLoadingWithError:(NSError *)error;

@end