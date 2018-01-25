//
//  CategoryTableViewCell.m
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 z. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"----- row = %ld, section : %ld", indexPath.row, indexPath.section);
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        titleLabel.tag = 1000;
        [self addSubview:titleLabel];
        
        UIImage *arrowImage = [UIImage imageNamed:@"register_three_arrow_up"];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KMainW - 130 - arrowImage.size.width, (45 - arrowImage.size.height) / 2, arrowImage.size.width, arrowImage.size.height)];
        arrowImageView.backgroundColor = [UIColor clearColor];
        arrowImageView.image = arrowImage;
        arrowImageView.tag = 1001;
        [self addSubview:arrowImageView];
        
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(KMainW - 120, 0, 50, 45);
        [editButton setBackgroundColor:[UIColor clearColor]];
        [editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        editButton.tag = 1002;
        [self addSubview:editButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(KMainW - 60, 0, 50, 45);
        [deleteButton setBackgroundColor:[UIColor clearColor]];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        deleteButton.tag = 1003;
        [self addSubview:deleteButton];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 44.5, KMainW - 10, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
    }
    return self;
}

- (void)setDataSource:(CategoryModel *)categoryModel cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *titleLabel = (UILabel *)[self viewWithTag:1000];
    UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:1001];
    UIButton *editButton = (UIButton *)[self viewWithTag:1002];
    UIButton *deleteButton = (UIButton *)[self viewWithTag:1003];

    UIImage *arrowUpImage = [UIImage imageNamed:@"register_three_arrow_up"];
    UIImage *arrowDownImage = [UIImage imageNamed:@"register_three_arrow_down"];
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
        titleLabel.frame = CGRectMake(10, 15, KMainW - 150 - arrowImageView.frame.size.width, 16);

    } else {
        titleLabel.frame = CGRectMake(20, 15, KMainW - 150, 16);

        if (subCategoryArray && [subCategoryArray count] > 0) {
            SubCategoryModel *subCategoryModel = [subCategoryArray objectAtIndex:(indexPath.row - 1)];
            titleLabel.text = subCategoryModel.name;
        }
        arrowImageView.hidden = YES;
    }
    editButton.buttonIndexPath = indexPath;
    deleteButton.buttonIndexPath = indexPath;
    [editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)editButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    self.editBlock(button.buttonIndexPath);
}

- (void)deleteButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    self.deleteBlock(button.buttonIndexPath);
}
@end
