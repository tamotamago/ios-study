//
//  Model.m
//  flickrAPISample
//
//  Created by 武田 祐一 on 12/11/09.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import "Model.h"

@implementation Model


// コンストラクタ
- (id)init
{
    self = [super init];
    if (self) {
        self.entries = [NSMutableArray array];
        // インスタンス変数の初期化
        // self.entriesとするとgetter, setter経由でのアクセスとなります
        // インスタンス変数へのダイレクトなアクセスは _entries と アンダースコア(_)をつけると可能になります
        // どちらを使うのかについては、講師にお尋ねください
    }
    return self;
}

- (void)fetchData
{
    // URLの文字列からNSURLインスタンスを生成します。
    NSURL *url = [NSURL URLWithString:@"http://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"];

    // 次に URLRequestを生成します
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // URLRequestを突っ込むためのキューを用意します
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 非同期にリクエストを実行します。
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *responce, NSData *data, NSError *error) {

        if (error) {
            [self.delegate modelDidFinishLoading:self WithError:error];
            return ;
        }

        NSError *jsonError = nil;

        // APIレスポンスがjsonで返ってくるので、シリアライズする
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        NSLog(@"%@", jsonError);

        if (jsonError) {
            [self.delegate modelDidFinishLoading:self WithError:jsonError];
            return;
        }

        _entries = [NSMutableArray array]; // インスタンス変数の初期化
        NSArray *items = json[@"items"]; // ハッシュの中の各エントリ
        for (NSDictionary *entry in items) { // for( hoge in fuga ) はいわゆるforeach文
            [_entries addObject:entry]; // _objectsに各エントリを追加して行く
        }

     [self.delegate modelDidFinishLoading:self WithError:nil];

    }];

}

@end
