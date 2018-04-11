//
//  ResultListHeadView.m
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ResultListHeadView.h"
#import "ShapeView.h"

@implementation ResultListHeadView

+ (ResultListHeadView *)headerViewWithTitle:(NSString *)title {
    ResultListHeadView *headView = [[ResultListHeadView alloc] initWithFrame:CGRectMake(0, 0, KMainW, 55)];
    headView.titleLabel.text = title;
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, KMainW, 40)];
        bgView.backgroundColor = kColor_12;
        [self addSubview:bgView];
        
        ShapeView *shapeView = [[ShapeView alloc]initWithFrame:CGRectMake(0, 15, 125, 40)];
        shapeView.bgColor = kColor_10;
        [self addSubview:shapeView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 28, 100, 14)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = kColor_1;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}
@end
