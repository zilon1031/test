//
//  UIButton+CLButton.m
//  CLQrCode
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 z. All rights reserved.
//

#import "UIButton+CLButton.h"
#import <objc/runtime.h>

static NSString *btnKey = @"btnKey";

@implementation UIButton (CLButton)

- (void)setButtonIndexPath:(NSIndexPath *)buttonIndexPath {
    objc_setAssociatedObject(self, &btnKey, buttonIndexPath, OBJC_ASSOCIATION_COPY);

}

- (NSIndexPath *)buttonIndexPath {
    return objc_getAssociatedObject(self, &btnKey);
}

@end
