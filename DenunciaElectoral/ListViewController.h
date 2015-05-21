//
//  ListViewController.h
//  DenunciaElectoral
//
//  Created by Carlos Castellanos on 20/05/15.
//  Copyright (c) 2015 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)IBOutlet UIScrollView *scroll;
@property (nonatomic,strong)IBOutlet UITableView *table;
@end
