//
//  ViewController.m
//  LinkageTableView
//
//  Created by Mac on 2018/1/12.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"
#import "NSString+CLString.h"

@interface ViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *firstChannelTableView;
@property (nonatomic, strong) UITableView *secondChannelTableView;
@property (nonatomic, strong) UITableView *thirdChannelTableView;
@property (nonatomic, strong) NSString *firstChannelString;
@property (nonatomic, strong) NSString *secondChannelString;
@property (nonatomic, strong) NSString *thirdChannelString;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *clearButton;


//@property (nonatomic, strong) NSMutableArray *firstChannelArray;
//@property (nonatomic, strong) NSMutableArray *secondChannelArray;
//@property (nonatomic, strong) NSMutableArray *thirdChannelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.firstChannelArray = [NSMutableArray array];
//    self.secondChannelArray = [NSMutableArray array];
//    self.thirdChannelArray = [NSMutableArray array];

    [self initWithCustomView];
}

- (void)initWithCustomView {
//    UIView *topView =   [[UIView alloc] init];
//    topView.frame = CGRectMake(0, 64, KMainW, 40);
//    topView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:topView];
//
//    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KMainW/2, 40)];
//    arrowView.backgroundColor = [UIColor yellowColor];
//    [topView addSubview:arrowView];
    UIImage *clearImage = [UIImage imageNamed:@"icon_delete"];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, KMainW - 25 - clearImage.size.width, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:self.titleLabel];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearButton.frame = CGRectMake(KMainW - 10 - clearImage.size.width, 40 - clearImage.size.height/ 2, clearImage.size.width, clearImage.size.height);
    [self.clearButton setImage:clearImage forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KMainW, KMainH - 64)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(KMainW / 2 * 3, KMainH - 64);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    UIButton *firstChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:firstChannelButton offsetX:0 buttonTitle:@"一级渠道" bgColor:nil];
    [self.scrollView addSubview:firstChannelButton];
    
    UIButton *secondChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:secondChannelButton offsetX:KMainW / 2 buttonTitle:@"二级渠道" bgColor:[UIColor yellowColor]];
    [self.scrollView addSubview:secondChannelButton];
    
    UIButton *thirdChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:thirdChannelButton offsetX:KMainW buttonTitle:@"三级渠道" bgColor:nil];
    [self.scrollView addSubview:thirdChannelButton];
    
    self.firstChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.firstChannelTableView];
    [self.scrollView addSubview:self.firstChannelTableView];

    self.secondChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(KMainW / 2, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.secondChannelTableView];
    self.secondChannelTableView.hidden = YES;
    [self.scrollView addSubview:self.secondChannelTableView];
    
    self.thirdChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(KMainW, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.thirdChannelTableView];
    self.thirdChannelTableView.hidden = YES;
    [self.scrollView addSubview:self.thirdChannelTableView];
}

- (void)initWithTopTitleBtn:(UIButton *)button offsetX:(CGFloat)offsetX buttonTitle:(NSString *)buttonTitle bgColor:(UIColor *)bgColor{
    button.frame = CGRectMake(offsetX, 0, KMainW / 2, 40);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    button.backgroundColor = [UIColor clearColor];
    button.userInteractionEnabled = NO;
    
    ShapeView *shapeView = [[ShapeView alloc] initWithFrame:CGRectMake(-10, 0, KMainW / 2, 40)];
    shapeView.bgColor = bgColor;
    [button addSubview:shapeView];
}

- (void)initWithChannelTableView:(UITableView *)channelTableView {
    channelTableView.backgroundColor = [UIColor whiteColor];
    channelTableView.delegate = self;
    channelTableView.dataSource = self;
    [channelTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.firstChannelTableView) {
        return 11;
    } else if (tableView == self.secondChannelTableView) {
        return 5;
    } else if (tableView == self.thirdChannelTableView) {
        return 7;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstChannelTableView) {
        static NSString *cellIdentifier = @"firstChannelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, KMainW / 2 - 30, 20)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = [UIFont systemFontOfSize:15.f];
            titleLabel.tag = 1000;
            [cell addSubview:titleLabel];
            
            UIImage *arrowImage = [UIImage imageNamed:@"icon_arrow_right"];
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KMainW/ 2 - 15, (40 - arrowImage.size.height) / 2, arrowImage.size.width, arrowImage.size.height)];
            arrowImageView.backgroundColor = [UIColor clearColor];
            arrowImageView.tag = 1001;
            arrowImageView.image = arrowImage;
            arrowImageView.hidden = YES;
            [cell addSubview:arrowImageView];
        }
        
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:1000];
        UIImageView *arrowImageView = (UIImageView *)[cell viewWithTag:1001];
        
        titleLabel.text = [NSString stringWithFormat:@"first = %ld", indexPath.row];
        if (indexPath.row %2 != 0) {
            arrowImageView.hidden = NO;
        }
        return cell;
    } else if (tableView == self.secondChannelTableView) {
        static NSString *cellIdentifier = @"secondChannelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, KMainW / 2 - 30, 20)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = [UIFont systemFontOfSize:15.f];
            titleLabel.tag = 2000;
            [cell addSubview:titleLabel];
            
            UIImage *arrowImage = [UIImage imageNamed:@"icon_arrow_right"];
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KMainW/ 2 - 15, (40 - arrowImage.size.height) / 2, arrowImage.size.width, arrowImage.size.height)];
            arrowImageView.backgroundColor = [UIColor clearColor];
            arrowImageView.tag = 2001;
            arrowImageView.image = arrowImage;
            arrowImageView.hidden = YES;
            [cell addSubview:arrowImageView];
        }
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:2000];
        UIImageView *arrowImageView1 = (UIImageView *)[cell viewWithTag:2001];
        
        titleLabel.text = [NSString stringWithFormat:@"second = %ld", indexPath.row];
        if (indexPath.row %2 == 0) {
            arrowImageView1.hidden = NO;
        }
        return cell;
    } else if (tableView == self.thirdChannelTableView) {
        static NSString *cellIdentifier = @"thirdChannelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, KMainW / 2 - 20, 20)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = [UIFont systemFontOfSize:15.f];
            titleLabel.tag = 3000;
            [cell addSubview:titleLabel];
        }
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:3000];
        titleLabel.text = [NSString stringWithFormat:@"third = %ld", indexPath.row];

        return cell;
    } else {
        return nil;
    }
}
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstChannelTableView) {
        self.firstChannelString = [NSString stringWithFormat:@"first = %ld", indexPath.row];
        if (indexPath.row %2 != 0) {
            self.secondChannelTableView.hidden = NO;
        } else {
            self.secondChannelTableView.hidden = YES;
        }
        self.secondChannelString = @"";

    } else if (tableView == self.secondChannelTableView) {
        self.secondChannelString = [NSString stringWithFormat:@"second = %ld", indexPath.row];
        if (indexPath.row %2 == 0) {
            self.thirdChannelTableView.hidden = NO;
            [self.scrollView setContentOffset:CGPointMake(KMainW/2, 0) animated:YES];

        } else {
            self.thirdChannelTableView.hidden = YES;
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        self.thirdChannelString = @"";

    } else if (tableView == self.thirdChannelTableView) {
        self.thirdChannelString = [NSString stringWithFormat:@"third = %ld", indexPath.row];
    }
    
    
    [self refreshChannelString];
}

- (void)refreshChannelString {
    NSString *titleString = @"";
    if (![NSString isBlankString:self.firstChannelString]) {
        titleString = self.firstChannelString;
        if (![NSString isBlankString:self.secondChannelString]) {
            titleString = [NSString stringWithFormat:@"%@ > %@", titleString, self.secondChannelString];
            if (![NSString isBlankString:self.thirdChannelString]) {
                titleString = [NSString stringWithFormat:@"%@ > %@", titleString, self.thirdChannelString];
            }
        }
    }
    self.titleLabel.text = titleString;
}
//#pragma mark - Fake Data
//- (void)fakeData {
//
//}

#pragma mark - Button Event
- (void)clearButtonClick:(id)sender {
    
}
@end

