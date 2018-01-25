//
//  ViewController.m
//  CLFoldingTableView
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ViewController.h"
#import "ManagerCategoryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithCustomView];
}

- (void)initWithCustomView {
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterButton setTitle:@"进入管理分类" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [enterButton setBackgroundColor:[UIColor whiteColor]];
    enterButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    enterButton.layer.borderWidth = 1;
    enterButton.layer.masksToBounds = YES;
    enterButton.layer.cornerRadius = 3;
    [enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.center.mas_equalTo(self.view);
    }];
}

- (void)enterButtonClick:(id)sender {
    ManagerCategoryViewController *managerCategoryVC = [[ManagerCategoryViewController alloc] init];
    [self presentViewController:managerCategoryVC animated:YES completion:^{
        
    }];
}


@end
