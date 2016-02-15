//
//  MComunityController.m
//  Cooking
//
//  Created by YongFangLili on 16/2/1.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "MComunityController.h"
#import "MComunitySocialModel.h"
#import "MComunitySocialCell.h"

@interface MComunityController ()<CKHTTPRequestDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MComunityController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self refreshData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:KImageOriginalWithName(@"notification") style:UIBarButtonItemStylePlain target:self action: @selector(jumpToNotificationVc)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MComunitySocialCell" bundle:nil] forCellReuseIdentifier:@"MComunitySocialCellID"];
    self.tableView.rowHeight = 77;
    
    // 刷新器
    self.refreshControl = [[UIRefreshControl alloc] init];
    // 设置下拉刷新时执行的动作
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    // 意见反馈
    [self setupFeedback];
    
    // 去除多余的分割线
    [LLCommonMethods setExtraCellLineHidden:self.tableView];

}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MComunitySocialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MComunitySocialCellID"];
    cell.dataModel = self.dataArray[indexPath.row];
    cell.contentView.backgroundColor = KMainBackgroudColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self jumpToSocialTheme:self.dataArray[indexPath.row]];
}

- (void)refreshData {
    [CKHTTPRequest getSocial:self params:nil];
}

-(void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

// 意见反馈
- (void)setupFeedback {
    UIButton *feedbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KScreenHeight - 40 - 10 - KTabBarHeight - KNavBarHeight, KScreenWidth, 40)];

    [feedbackBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
    [feedbackBtn setTitleColor:KUIColorFromRGB(0x5e5e5e) forState:UIControlStateNormal];
    feedbackBtn.titleLabel.font = KFont(12);
    [feedbackBtn addTarget:self action:@selector(jumpToFeedbackVc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:feedbackBtn];
}

#pragma mark - Vc Jump
// 跳转消息页面
- (void)jumpToNotificationVc {
   
   // add coding...
}

// 跳转意见反馈
- (void)jumpToFeedbackVc {
    
    // add coding...

}

// 跳转社区主题界面
- (void)jumpToSocialTheme:(MComunitySocialModel *)selectedModel {

    // add coding...

}

- (void)requestFinished:(id)responseDict cmd:(NSString *)cmd postdict:(NSDictionary *)postdict {

    NSLog(@"responseDict===>%@",responseDict);
    
    if ([responseDict[@"status"] isEqualToString:@"ok"]) {
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSDictionary *dict in responseDict[@"content"][@"forums"]) {
            MComunitySocialModel *model = [MTLJSONAdapter modelOfClass:[MComunitySocialModel class] fromJSONDictionary:dict error:nil];
            model.contentType = @"forums";
            [arrayM addObject:model];
        }
        
        MComunitySocialModel *model = [MTLJSONAdapter modelOfClass:[MComunitySocialModel class] fromJSONDictionary:responseDict[@"content"][@"shouts"] error:nil];
        model.contentType = @"shouts";
        [arrayM addObject:model];
        
        self.dataArray = [arrayM copy];
    }
    
}

- (void)requestFailWithError:(NSError *)error cmd:(NSString *)cmd postdict:(NSDictionary *)postdict {

    NSLog(@"error---->%@",error);
}

@end
