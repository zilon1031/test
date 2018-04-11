//
//  ResultListHeadView.h
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultListHeadView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

+ (ResultListHeadView *)headerViewWithTitle:(NSString *)title;

@end
