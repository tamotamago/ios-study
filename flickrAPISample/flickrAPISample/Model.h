//
//  Model.h
//  flickrAPISample
//
//  Created by 武田 祐一 on 12/11/09.
//  Copyright (c) 2012年 武田 祐一. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate; // ModelDelegateというプロトコルを作りますという前方宣言

// クラスの宣言
//        クラス名 : 親クラス
@interface Model : NSObject

// プロパティ(インスタンス変数)の宣言
// nonatomicはマルチスレッドの時の動作を保証しない
// strong, weakはオブジェクトの保有をするかどうかを宣言
@property (nonatomic, weak) id<ModelDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *entries;

- (void)fetchData;

@end

// delegateをprotocolで宣言
// protocolとは実装の一部を各クラスで分けて実装する仕組みのこと
@protocol ModelDelegate <NSObject>

- (void)modelDidFinishLoading:(Model *)model WithError:(NSError *)error;

@end