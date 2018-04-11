//
//  NoDocumentViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 z. All rights reserved.
//

#import "NoDocumentViewController.h"
#import "NoDocumentBarcodeView.h"
#import "NoMerchantView.h"
#import "ResultListHeadView.h"

#import "PlatformCell.h"
#import "PlatformTableItem.h"

#import "MerchantCell.h"
#import "MerchantTableItem.h"

@interface NoDocumentViewController () <RETableViewManagerDelegate>

@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *platformArray;
@property (nonatomic, strong) NSArray *merchantArray;

@end

@implementation NoDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTopLabel.text = @"扫一扫";
    
    [self addRightNaviButton:@"关闭" action:@selector(rightNaviButtonClick:)];
    
    self.platformArray = [NSMutableArray array];
    self.platformArray = [NSMutableArray array];
    [self plantformFakeData];
    [self merchantFakeData];
//    [self initWithNoDocumentView];
    [self initWithCustomView];
}

#pragma mark - Init View
- (void)initWithNoDocumentView {
    NoDocumentBarcodeView *noDocumentBarcodeView = [[NoDocumentBarcodeView alloc] initWithFrame:CGRectMake(0, 64, KMainW, KMainH) scanResult:self.scanResultString];
    [self.view addSubview:noDocumentBarcodeView];
}

- (void)initWithCustomView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KMainW, KMainH - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.manager[@"PlatformTableItem"] = @"PlatformCell";
    self.manager[@"MerchantTableItem"] = @"MerchantCell";

    self.tableView.tableHeaderView = [self formattingHeaderView];
    
    if ([self.merchantArray count] == 0) {
        self.tableView.tableFooterView = [[NoMerchantView alloc] initWithFrame:CGRectMake(0, 0, KMainW, 190)];
    } else {
        self.tableView.tableFooterView = nil;
    }
    
    [self addItems];
}

- (UIView *)formattingHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KMainW, 50)];
    headerView.backgroundColor = kColor_1;
    [self.view addSubview:headerView];
    
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, KMainW - 24, 16)];
    productLabel.text = @"【安井】肉松卷800g";
    productLabel.backgroundColor = [UIColor clearColor];
    productLabel.textColor = kColor_3;
    productLabel.textAlignment = NSTextAlignmentLeft;
    productLabel.font = [UIFont systemFontOfSize:15.f];
    [headerView addSubview:productLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, KMainW, 1)];
    line.backgroundColor = kColor_7;
    [headerView addSubview:line];
    
    return headerView;
}

- (void)addItems {
    ResultListHeadView *platformHeadView = [ResultListHeadView headerViewWithTitle:@"平台产品库"];
    RETableViewSection *platformSection = [RETableViewSection sectionWithHeaderView:platformHeadView];
    [self.manager addSection:platformSection];
    
    for (NSDictionary *dict in self.platformArray) {
        PlatformTableItem *platformItem = [PlatformTableItem platformTableItemWithProductId:dict[@"productId"] image:dict[@"imageUrl"] cuisineArray:dict[@"cuisineArray"] nameString:dict[@"nameString"] inventory:dict[@"inventory"] hotCount:dict[@"hotCount"]];
        [platformSection addItem:platformItem];
    }
    
    ResultListHeadView *merchantHeadView = [ResultListHeadView headerViewWithTitle:@"附近在卖的商家"];
    RETableViewSection *merchantSection = [RETableViewSection sectionWithHeaderView:merchantHeadView];
    [self.manager addSection:merchantSection];
    
    for (NSDictionary *dict in self.merchantArray) {
        MerchantTableItem *merchantItem = [MerchantTableItem merchantTableItemWithMerchantId:dict[@"merchantId"] MerchantName:dict[@"merchantName"] ImageUrl:dict[@"imageUrl"] Name:dict[@"name"] Inventory:dict[@"inventory"] RetailAllPrice:dict[@"retailAllPrice"] RetailSinglePrice:dict[@"retailSinglePrice"]];
        [merchantSection addItem:merchantItem];
    }
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;//return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;//return CGFLOAT_MIN;
}

#pragma mark - UIButton Event
- (void)rightNaviButtonClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Fake Data
- (void)plantformFakeData {
    self.platformArray = @[@{@"productId":@"1",
                             @"imageUrl":@"",
                             @"cuisineArray":@[@{@"name":@"凉菜",@"type":@"1"},
                                               @{@"name":@"热菜",@"type":@"2"},
                                               @{@"name":@"东北菜",@"type":@"3"}],
                             @"nameString":@"【安井】肉松卷 儿童家庭营养早餐 面点 包子",
                             @"inventory":@"200/包*10",
                             @"hotCount":@"12564",
                             },
                           @{@"productId":@"2",
                             @"imageUrl":@"",
                             @"cuisineArray":@[@{@"name":@"闽菜",@"type":@"1"},
                                               @{@"name":@"东北菜",@"type":@"3"}],
                             @"nameString":@"【安井】核桃包360g/10个",
                             @"inventory":@"360g/包*10",
                             @"hotCount":@"1650",
                             }];
}

- (void)merchantFakeData {
    self.merchantArray = @[@{@"merchantId":@"1",
                             @"merchantName":@"福建买买买信息科技有限公司",
                             @"imageUrl":@"",
                             @"name":@"【安井】肉松卷港式点心",
                             @"inventory":@"300g/包*10",
                             @"retailAllPrice":@"220.00",
                             @"retailSinglePrice":@"12.00"},
                           @{@"merchantId":@"2",
                             @"merchantName":@"福建苏天下食品有限公司",
                             @"imageUrl":@"",
                             @"name":@"【安井】核桃包 360g/包",
                             @"inventory":@"360g/包*10",
                             @"retailAllPrice":@"320.00",
                             @"retailSinglePrice":@"18.80"},
                           @{@"merchantId":@"3",
                             @"merchantName":@"娜可露露冻品批发",
                             @"imageUrl":@"",
                             @"name":@"【安井】香芋地瓜丸子 油炸食品",
                             @"inventory":@"420g/袋*10",
                             @"retailAllPrice":@"0",
                             @"retailSinglePrice":@"0"},
                           @{@"merchantId":@"4",
                             @"merchantName":@"素天下食品有限公司",
                             @"imageUrl":@"",
                             @"name":@"【安井】手工虾皇饺 港式茶点",
                             @"inventory":@"300g/包*10",
                             @"retailAllPrice":@"380.00",
                             @"retailSinglePrice":@"40.00"},
                           @{@"merchantId":@"5",
                             @"merchantName":@"娜可露露冻品批发",
                             @"imageUrl":@"",
                             @"name":@"【安井】香芋地瓜丸子 油炸",
                             @"inventory":@"420g/袋*10",
                             @"retailAllPrice":@"52.00",
                             @"retailSinglePrice":@"5.50"}];
}

@end
