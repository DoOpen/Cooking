//
//  LLCommonMethods.m
//  Cooking
//
//  Created by ocarol on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "LLCommonMethods.h"

@implementation LLCommonMethods

/**
 *  去除tableView多余的分割线
 *
 *  @param tableView 需要去除多余分割线的tabbleView
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end
