//
//  ManagerCategoryViewController.m
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ManagerCategoryViewController.h"
#import "CategoryModel.h"

#define kAddSubButtonBaseTag 3000

@interface ManagerCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *showArray;

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UIView *emptyView;
@end

@implementation ManagerCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    self.dataArray = [NSMutableArray array];
    self.showArray = [NSMutableArray array];
    [self fakeData];

    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithCustomView];
}

- (void)initWithCustomView {
    //顶部模仿NavigationBar
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 64));
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 1));
        make.bottom.mas_equalTo(topView.mas_bottom);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 40));
        make.left.mas_equalTo(topView.mas_left);
        make.bottom.mas_equalTo(topView.mas_bottom);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"管理分类";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 140, 40));
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.bottom.mas_equalTo(topView.mas_bottom);
    }];
    
    //空白页
    self.emptyView = [[UIView alloc] init];
    self.emptyView.backgroundColor = [UIColor lightGrayColor];
    self.emptyView.hidden = YES;
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, KMainH - 108));
        make.top.mas_equalTo(self.view).with.mas_offset(64);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.backgroundColor = [UIColor clearColor];
    emptyLabel.text = @"暂时没有分类";
    emptyLabel.textColor = [UIColor blackColor];
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.font = [UIFont systemFontOfSize:18.f];
    [self.emptyView addSubview:emptyLabel];
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 20, 30));
        make.left.mas_equalTo(self.emptyView.mas_left).with.mas_offset(10);
        make.centerY.mas_equalTo(self.emptyView.mas_centerY);
    }];
    
    //品种分类列表
    self.categoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.categoryTableView.backgroundColor = [UIColor clearColor];
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.categoryTableView.hidden = YES;
    [self.categoryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.categoryTableView];
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, KMainH - 108));
        make.top.mas_equalTo(self.view).with.mas_offset(64);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    //底部添加一级分类按钮
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setBackgroundColor:[UIColor clearColor]];
    [bottomButton setTitle:@"+ 新建分类" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    bottomButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bottomButton.layer.borderWidth = 1;
    [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 44));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self refreshView];
}

- (void)refreshView {
    if ([self.showArray count] == 0) {
        self.emptyView.hidden = NO;
        self.categoryTableView.hidden = YES;
    } else {
        self.emptyView.hidden = YES;
        self.categoryTableView.hidden = NO;
        
        [self.categoryTableView reloadData];
    }
}
#pragma mark - UIButton Event
- (void)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
     
- (void)bottomButtonClick:(id)sender {
    if ([self.showArray count] == 0) {
        [self.showArray addObjectsFromArray:self.dataArray];
    } else {
        [self.showArray removeAllObjects];
    }
    [self refreshView];
}
- (void)addSubCategoryButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"button tag : %ld", button.tag - kAddSubButtonBaseTag);
}
#pragma mark - Fake Data
- (void)fakeData {
    CategoryModel *categoryModel1 = [self increaseCategoryModel:1 subCategoryCount:0];
    CategoryModel *categoryModel2 = [self increaseCategoryModel:2 subCategoryCount:1];
    CategoryModel *categoryModel3 = [self increaseCategoryModel:3 subCategoryCount:0];
    CategoryModel *categoryModel4 = [self increaseCategoryModel:4 subCategoryCount:4];
    CategoryModel *categoryModel5 = [self increaseCategoryModel:5 subCategoryCount:2];
    CategoryModel *categoryModel6 = [self increaseCategoryModel:6 subCategoryCount:8];
    
    self.dataArray = [NSMutableArray arrayWithObjects:categoryModel1, categoryModel2, categoryModel3, categoryModel4, categoryModel5, categoryModel6, nil];
//    self.showArray = [NSMutableArray arrayWithObjects:categoryModel1, categoryModel2, categoryModel3, categoryModel4, categoryModel5, categoryModel6, nil];
}
- (CategoryModel *)increaseCategoryModel:(NSInteger)cid subCategoryCount:(NSInteger)count{
    CategoryModel *categoryModel = [[CategoryModel alloc] init];
    categoryModel.id = cid;
    categoryModel.name = [NSString stringWithFormat:@"一级类别%ld", cid];
    if (count > 0) {
        NSMutableArray *subCategoryArray = [self increaseSubCategoryArray:count categoryId:cid];
        categoryModel.list = subCategoryArray;
    } else {
        categoryModel.list = nil;
    }
    categoryModel.isUnfold = NO;
    return categoryModel;
}

- (NSMutableArray *)increaseSubCategoryArray:(NSInteger)arrayCount categoryId:(NSInteger)categoryId{
    NSMutableArray *subCategoryArray = [NSMutableArray array];
    for (int i = 0; i < arrayCount; i++) {
        SubCategoryModel *subCategoryModel = [[SubCategoryModel alloc] init];
        subCategoryModel.id = categoryId*10 + i;
        subCategoryModel.fid = categoryId;
        subCategoryModel.name = [NSString stringWithFormat:@"二级类别%ld -- %d", categoryId, i];
        [subCategoryArray addObject:subCategoryModel];
    }
    
    return subCategoryArray;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.showArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 1;
    CategoryModel *categoryModel = [self.showArray objectAtIndex:section];
    if (categoryModel.isUnfold) {
        NSMutableArray *subCategoryArray = [NSMutableArray arrayWithArray:categoryModel.list];
        count = count + [subCategoryArray count];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        titleLabel.tag = 1000;
        [cell addSubview:titleLabel];
        if (indexPath.row == 0) {
            titleLabel.frame = CGRectMake(10, 15, 300, 16);
            
            UIImage *arrowImage = [UIImage imageNamed:@"register_three_arrow_up"];
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(305, (45 - arrowImage.size.height) / 2, arrowImage.size.width, arrowImage.size.height)];
            arrowImageView.backgroundColor = [UIColor clearColor];
            arrowImageView.image = arrowImage;
            arrowImageView.tag = 1001;
            [cell addSubview:arrowImageView];
        } else {
            titleLabel.frame = CGRectMake(20, 15, 300, 16);
        }
        
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton setBackgroundColor:[UIColor clearColor]];
        [editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        editButton.tag = 1002;
        [cell addSubview:editButton];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 44.5, KMainW - 10, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:lineView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1000];
    UIImageView *arrowImageView = (UIImageView *)[cell viewWithTag:1001];
    UIImage *arrowUpImage = [UIImage imageNamed:@"register_three_arrow_up"];
    UIImage *arrowDownImage = [UIImage imageNamed:@"register_three_arrow_down"];
    
    CategoryModel *categoryModel = [self.showArray objectAtIndex:indexPath.section];
    NSMutableArray *subCategoryArray = categoryModel.list;

    if (indexPath.row == 0) {
        titleLabel.text = categoryModel.name;
        if ([subCategoryArray count] == 0) {
            arrowImageView.hidden = YES;
        } else {
            arrowImageView.hidden = NO;
        }
        if (categoryModel.isUnfold) {
            arrowImageView.image = arrowUpImage;
        } else {
            arrowImageView.image = arrowDownImage;
        }
    } else {
        if (subCategoryArray && [subCategoryArray count] > 0) {
            SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
            titleLabel.text = subCategoryModel.name;
        }
        arrowImageView.hidden = YES;

    }
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.f;
    } else {
        return 20.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:0.8f];
    if (section == 0) {
        headView.frame = CGRectMake(0, 0, KMainW, 10);
    } else {
        headView.frame = CGRectMake(0, 0, KMainW, 20);
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height - 0.5, KMainW, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineView];
    
    return headView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KMainW, 45)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, KMainW, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:lineView];
    
    UIButton *addSubCategoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addSubCategoryButton.frame = CGRectMake(0, 0, footView.frame.size.width, footView.frame.size.height);
    addSubCategoryButton.backgroundColor = [UIColor whiteColor];
    [addSubCategoryButton setTitle:@"+ 添加子分类" forState:UIControlStateNormal];
    [addSubCategoryButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addSubCategoryButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [addSubCategoryButton addTarget:self action:@selector(addSubCategoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addSubCategoryButton.tag = kAddSubButtonBaseTag + section;
    [footView addSubview:addSubCategoryButton];
    
    return footView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CategoryModel *categoryModel = [self.showArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        NSLog(@"category -- %@", categoryModel.name);
        if (categoryModel.isUnfold) {
            categoryModel.isUnfold = NO;
        } else {
            categoryModel.isUnfold = YES;
        }
        [self refreshView];
    } else {
        NSMutableArray *subCategoryArray = categoryModel.list;
        SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
        NSLog(@"category -- %@", subCategoryModel.name);
    }
}

@end
