//
//  ViewController.m
//  LinkageTableView
//
//  Created by Mac on 2018/1/12.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"

@interface ViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *firstChannelTableView;
@property (nonatomic, strong) UITableView *secondChannelTableView;
@property (nonatomic, strong) UITableView *thirdChannelTableView;
@property (nonatomic, strong) NSMutableArray *firstChannelArray;
@property (nonatomic, strong) NSMutableArray *secondChannelArray;
@property (nonatomic, strong) NSMutableArray *thirdChannelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.firstChannelArray = [NSMutableArray array];
    self.secondChannelArray = [NSMutableArray array];
    self.thirdChannelArray = [NSMutableArray array];

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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KMainW, KMainH - 64)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(KMainW / 2 * 3, KMainH - 64);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UIButton *firstChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:firstChannelButton offsetX:0 buttonTitle:@"一级渠道"];
    [scrollView addSubview:firstChannelButton];
    
    UIButton *secondChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:secondChannelButton offsetX:KMainW / 2 buttonTitle:@"二级渠道"];
    [scrollView addSubview:secondChannelButton];
    
    UIButton *thirdChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initWithTopTitleBtn:thirdChannelButton offsetX:KMainW buttonTitle:@"三级渠道"];
    [scrollView addSubview:thirdChannelButton];
    
    self.firstChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.firstChannelTableView];
    [scrollView addSubview:self.firstChannelTableView];

    self.secondChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(KMainW / 2, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.secondChannelTableView];
    [scrollView addSubview:self.secondChannelTableView];
    
    self.thirdChannelTableView = [[UITableView alloc] initWithFrame:CGRectMake(KMainW, 40, KMainW / 2, KMainH - 104) style:UITableViewStylePlain];
    [self initWithChannelTableView:self.thirdChannelTableView];
    [scrollView addSubview:self.thirdChannelTableView];
}

- (void)initWithTopTitleBtn:(UIButton *)button offsetX:(CGFloat)offsetX buttonTitle:(NSString *)buttonTitle{
    button.frame = CGRectMake(offsetX, 0, KMainW / 2, 40);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    button.backgroundColor = [UIColor blueColor];
    button.userInteractionEnabled = NO;
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
        return [self.firstChannelArray count];
    } else if (tableView == self.secondChannelTableView) {
        return [self.secondChannelArray count];
    } else if (tableView == self.thirdChannelTableView) {
        return [self.thirdChannelArray count];
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
        return cell;
    } else {
        return nil;
    }
}
@end
