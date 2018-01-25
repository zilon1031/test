//
//  Macro.h
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 z. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//获取屏幕宽高
#define KMainW [UIScreen mainScreen].bounds.size.width
#define KMainH [UIScreen mainScreen].bounds.size.height

//根据一种屏幕尺寸开发，等比缩放到其他尺寸（如：375为4.7寸屏）
#define KScreenRate (375 / KMainW)
#define KSuitFloat(float) (float / KScreenRate)
#define KSuitSize(width, height) CGSizeMake(width / KScreenRate, height / KScreenRate)
#define KSuitPoint(x, y) CGPointMake(x / KScreenRate, y / KScreenRate)
#define KSuitFrame(x, y, width, heigth) CGRectMake(x / KScreenRate, y / KScreenRate, width / KScreenRate, heigth / KScreenRate)

//防止Block循环引用
#define weakSelf(object) __weak __typeof__(object) weak##_##object = object;
#define strongSelf(object) __strong __typeof__(object) object = weak##_##object;

//Debug下输出打印信息，Release下不输出打印信息
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define printf(...) printf(__VA_ARGS__)
#else
#define NSLog(...)
#define printf(...)
#endif

#endif /* Macro_h */

