//
//  ManagerCategoryViewController.m
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ManagerCategoryViewController.h"
#import "CategoryModel.h"
#import "CategoryTableViewCell.h"

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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *commitAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *newNameTextField = alertController.textFields.firstObject;
            
            CategoryModel *categoryModel = [[CategoryModel alloc] init];
            categoryModel.name = newNameTextField.text;
            categoryModel.id = [self.showArray count] + 1;
            categoryModel.list = nil;
            categoryModel.isUnfold = NO;
            
            [self.showArray addObject:categoryModel];
            
            [self.categoryTableView reloadData];
        }];
        [alertController addAction:commitAlertAction];
        
        UIAlertAction *cancelAlertAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAlertAction];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入用户名";
        }];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [self refreshView];
}
- (void)addSubCategoryButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"button tag : %ld", button.tag - kAddSubButtonBaseTag);
    
    CategoryModel *categoryModel = [self.showArray objectAtIndex:(button.tag - kAddSubButtonBaseTag)];
    NSMutableArray *subCategoryArray = [NSMutableArray arrayWithArray:categoryModel.list];
//    SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
    SubCategoryModel *lastSubCategoryModel = [subCategoryArray lastObject];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields.firstObject;
        SubCategoryModel *subCategoryModel = [[SubCategoryModel alloc] init];
        subCategoryModel.id = lastSubCategoryModel.id + 1;
        subCategoryModel.name = textField.text;
        subCategoryModel.fid = lastSubCategoryModel.fid;

        [subCategoryArray addObject:subCategoryModel];
        categoryModel.list = subCategoryArray;
        [self.showArray replaceObjectAtIndex:(button.tag - kAddSubButtonBaseTag) withObject:categoryModel];
        
        [self.categoryTableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:commitAction];
    [alertController addAction:cancelAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
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
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CategoryModel *categoryModel = [self.showArray objectAtIndex:indexPath.section];
    [cell setDataSource:categoryModel cellForRowAtIndexPath:indexPath];
    
    weakSelf(self)
    [cell setEditBlock:^(NSIndexPath *indexPath) {
        strongSelf(self)
        CategoryModel *categoryModel = [self.showArray objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *textField = alertController.textFields.firstObject;
                categoryModel.name = textField.text;
                [self.showArray replaceObjectAtIndex:indexPath.section withObject:categoryModel];
                
                [self.categoryTableView reloadData];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:commitAction];
            [alertController addAction:cancelAction];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = categoryModel.name;
            }];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else {
            NSMutableArray *subCategoryArray = [NSMutableArray arrayWithArray:categoryModel.list];
            SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *textField = alertController.textFields.firstObject;
                subCategoryModel.name = textField.text;
                
                [subCategoryArray replaceObjectAtIndex:(indexPath.row - 1) withObject:subCategoryModel];
                categoryModel.list = subCategoryArray;
                [self.showArray replaceObjectAtIndex:indexPath.section withObject:categoryModel];

                [self.categoryTableView reloadData];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:commitAction];
            [alertController addAction:cancelAction];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = subCategoryModel.name;
            }];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    [cell setDeleteBlock:^(NSIndexPath *indexPath) {
        strongSelf(self)
        CategoryModel *categoryModel = [self.showArray objectAtIndex:indexPath.section];
        NSMutableArray *subCategoryArray = [NSMutableArray arrayWithArray:categoryModel.list];
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray *tempArray = [NSMutableArray array];
                for (SubCategoryModel *subCategoryModel in subCategoryArray) {
                    CategoryModel *newCategoryModel = [[CategoryModel alloc] init];
                    newCategoryModel.id = subCategoryModel.id;
                    newCategoryModel.name = subCategoryModel.name;
                    newCategoryModel.list = nil;
                    newCategoryModel.isUnfold = NO;
                    if ([tempArray indexOfObject:newCategoryModel] == NSNotFound) {
                        [tempArray addObject:newCategoryModel];
                    }
                }
                if ([tempArray count] > 0) {
                    [self.showArray addObjectsFromArray:tempArray];
                }
                if ([self.showArray indexOfObject:categoryModel] != NSNotFound) {
                    [self.showArray removeObject:categoryModel];
                }
                [self.categoryTableView reloadData];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:deleteAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑分类名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (indexPath.row > 0) {
                    [subCategoryArray removeObjectAtIndex:(indexPath.row - 1)];
                }
                categoryModel.list = subCategoryArray;
                [self.showArray replaceObjectAtIndex:indexPath.section withObject:categoryModel];
                
                [self.categoryTableView reloadData];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:deleteAction];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
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
    addSubCategoryButton.backgroundColor = [UIColor clearColor];
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
        if (categoryModel.isUnfold) {
            categoryModel.isUnfold = NO;
        } else {
            categoryModel.isUnfold = YES;
        }
        [self.categoryTableView reloadData];
    } else {
        NSMutableArray *subCategoryArray = categoryModel.list;
        SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
    }
}

@end
