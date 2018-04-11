//
//  BarcodeResultViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/2/2.
//  Copyright © 2018年 z. All rights reserved.
//

#import "BarcodeResultViewController.h"
#import <IGListKit.h>
#import "IGListCollectionView.h"


@interface BarcodeResultViewController ()<IGListAdapterDataSource>
//IGListAdapter来控制collectionView的数据显示
@property (nonatomic, strong)IGListAdapter *adapter;
//IGListCollectionView继承自UICollectionView,用来代替UITableView
@property (nonatomic, strong)IGListCollectionView *collectionView;
//数据源数组
@property (nonatomic, strong) NSArray *platformArray;
@property (nonatomic, strong) NSArray *merchantArray;
@end

@implementation BarcodeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.platformArray = [NSMutableArray array];
    self.platformArray = [NSMutableArray array];
    [self plantformFakeData];
    [self merchantFakeData];
    
    [self.view addSubview:self.collectionView];
    //给adapter赋值collectionView
    self.adapter.collectionView=self.collectionView;
    //给adapter赋值dataSource
    self.adapter.dataSource=self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame=self.view.bounds;
}
-(void)onControl:(UISegmentedControl *)control{
    [self.adapter performUpdatesAnimated:YES completion:nil];
}

- (IGListAdapter *)adapter {
    if (!self.adapter) {
        /**
         默认初始化IGListAdapter
         参数1：IGListAdapterUpdater，是一个遵循了IGListUpdatingDelegate的对象，它处理每行更新。
         参数2：viewController，是包含IGListAdapter的UIViewController。 可以用来push到其他控制器
         参数3：workingRangeSize是工作范围的大小，它可以让你为刚好在可见范围之外的视图做一些准备工作，暂时没用到给0。
         */
        self.adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self workingRangeSize:0];
    }
    return _adapter;
}
- (IGListCollectionView *)collectionView {
    if (!self.collectionView) {
        self.collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return self.collectionView;
}

-(IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
//    if ([object isKindOfClass:[NSString class]]) {
//        return [ExpandableSectionController new];
//    }
//    else if ([object isKindOfClass:[GridItem class]]) {
//        return [GridSectionController new];
//    }
//    else {
//        return [UserSectionController new];
//    }
    return nil;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
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
