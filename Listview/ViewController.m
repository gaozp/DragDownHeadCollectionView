//
//  ViewController.m
//  Listview
//
//  Created by zhipenggao on 2022/7/29.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat kDefaultInsets;

@property (nonatomic, assign) CGFloat kDefaultIMGHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kDefaultInsets = 47; // 此处的insets可以自己配置
    self.kDefaultIMGHeight = 240;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.frame = CGRectMake(0, self.kDefaultIMGHeight - 12, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.userInteractionEnabled = YES;
        [_scrollView setContentOffset:CGPointMake(0, self.kDefaultInsets)];
        [_scrollView setContentInset:UIEdgeInsetsMake(self.kDefaultInsets, 0, 0, 0)];
        _scrollView.contentSize =  CGSizeMake( self.view.frame.size.width, self.view.frame.size.height * 2);
    }
    return _scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + self.kDefaultInsets;
    if (offsetY < 0 && scrollView.frame.origin.y < self.kDefaultIMGHeight) { // 当前player的高度
        NSLog(@"zhipenggao : offset : %.2f  origin.y:%.2f", scrollView.contentOffset.y, scrollView.frame.origin.y);
        self.scrollView.layer.cornerRadius = 12; // 圆角可以自己配置
        self.scrollView.frame = CGRectMake(0, scrollView.frame.origin.y + (-offsetY), scrollView.frame.size.width, scrollView.frame.size.height);
    } else if (offsetY > 0 && self.scrollView.frame.origin.y > self.kDefaultInsets) {
        NSLog(@"zhipenggao : offset : %.2f  origin.y:%.2f", offsetY, scrollView.frame.origin.y);
        self.scrollView.frame = CGRectMake(0, scrollView.frame.origin.y - offsetY, scrollView.frame.size.width, scrollView.frame.size.height);
        [self.scrollView setContentOffset:CGPointMake(0,-self.kDefaultInsets)];
    }
}

@end
