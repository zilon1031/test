//
//  CategoryTableViewCell.h
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryModel.h"

typedef void(^EditCategoryBlock)(NSIndexPath *indexPath);
typedef void(^DeleteCategoryBlock)(NSIndexPath *indexPath);

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic, copy) EditCategoryBlock editBlock;
@property (nonatomic, copy) DeleteCategoryBlock deleteBlock;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)setDataSource:(CategoryModel *)categoryModel cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
