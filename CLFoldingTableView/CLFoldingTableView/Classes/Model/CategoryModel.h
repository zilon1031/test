//
//  CategoryModel.h
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 z. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SubCategoryModel
@end

@interface CategoryModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray <SubCategoryModel>*list;
@property (nonatomic, assign) BOOL isUnfold;        //是否展开

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *name;

@end
