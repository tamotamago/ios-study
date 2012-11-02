//
//  Model.h
//  tableViewSample
//
//  Created by 武田 祐一 on 12/11/02.
//
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

- (void)addEntry:(NSDictionary *)entry;

- (NSDictionary *)entryAtIndex:(NSInteger)index;

- (NSInteger)count;

@end
