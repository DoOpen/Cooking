//
//  issueTemplate4Cell.h
//  Cooking
//
//  Created by 李永方 on 16/2/18.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCookModel.h"

@interface issueTemplate4Cell : UITableViewCell

@property (nonatomic, strong)McookissueItemsModel *issueItemM;

+(instancetype)issueWithTabelView:(UITableView *)tabelview;

@end
