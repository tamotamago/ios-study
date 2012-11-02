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

@end
