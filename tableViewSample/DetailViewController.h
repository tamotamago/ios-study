//
//  DetailViewController.h
//  tableViewSample
//
//  Created by 武田 祐一 on 2012/11/01.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
