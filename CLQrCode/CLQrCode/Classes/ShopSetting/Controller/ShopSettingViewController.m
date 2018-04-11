//
//  ShopSettingViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/2/5.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ShopSettingViewController.h"

@interface ShopSettingViewController ()<RETableViewManagerDelegate>

@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RETableViewSection *basicInfoSection;
@property (nonatomic, strong) RETableViewSection *pricesSection;
@property (nonatomic, strong) RETableViewSection *shopSettingSection;
//@property (nonatomic, strong) RETableViewSection *basicControlsSection;


@end

@implementation ShopSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTopLabel.text = @"店铺设置";
    
    [self initWithCustomView];

}

#pragma mark - Init View
- (void)initWithCustomView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KMainW, KMainH - 114) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    [self addBasicInfoItem];
    [self addPricesItem];
    [self addShopSettingItem];
}
- (void)addBasicInfoItem {
    self.basicInfoSection = [RETableViewSection sectionWithHeaderTitle:@"基本资料设置"];
    RETextItem *categoryItem = [RETextItem itemWithTitle:@"主营品类" value:@"" placeholder:@"请选择"];
    [self.basicInfoSection addItem:categoryItem];
    [self.manager addSection:self.basicInfoSection];
}
- (void)addPricesItem {
    self.pricesSection = [RETableViewSection section];
    [self.manager addSection:self.pricesSection];
}
- (void)addShopSettingItem {
    self.shopSettingSection = [RETableViewSection sectionWithHeaderTitle:@"店铺主页功能设置"];
    [self.manager addSection:self.shopSettingSection];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50.f;
    } else if (section == 1) {
        return 15.f;
    } else if (section == 2) {
        return 50.f;
    } else {
        return 0.1;//return CGFLOAT_MIN;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 20.f;
    } else {
        return 0.1;//return CGFLOAT_MIN;
    }
}

@end
