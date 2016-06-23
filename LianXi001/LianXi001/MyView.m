//
//  MyView.m
//  LianXi001
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "MyView.h"

#define tagIndex   20160606

@interface MyView ()

@property (nonatomic,strong)UIScrollView   *scrollView;
@property (nonatomic,strong)UIView *breakline;

@end
@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        UIView *breakline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        breakline.backgroundColor = [UIColor lightGrayColor];
        self.breakline = breakline;
        [self addSubview:breakline];
    }
    return self;
}

- (void)setMenuArray:(NSMutableArray *)menuArray {
    
    _menuArray = menuArray;
    [self setUpMenuBtns];
}

- (void)setUpMenuBtns {
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    
    UIFont *btnFont = [UIFont systemFontOfSize:16];
    
    for (int i = 0; i < self.menuArray.count; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = tagIndex + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:self.menuArray[i] forState:normal];
        menuBtn.backgroundColor = [UIColor clearColor];
        menuBtn.titleLabel.font = btnFont;
        [menuBtn setTitleColor:[UIColor colorWithRed:104/255.0 green:104/255.0 blue:124/255.0 alpha:1] forState:normal];
        
        CGFloat  menuBtnX = 15.f;
        
        if (self.scrollView.subviews.count > 0) {
            
            menuBtnX = CGRectGetMaxX([self.scrollView.subviews lastObject].frame) + 15;
        }
        
        CGRect btnRect = [self.menuArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btnFont} context:nil];
        menuBtn.frame = CGRectMake(menuBtnX, 5, btnRect.size.width, btnRect.size.height + 10);
        [self.scrollView addSubview:menuBtn];
        
        if (i == 0) {
            self.selectedBtn = menuBtn;
        }
        
    }
    
    if (self.scrollView.subviews.count > 0) {
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.scrollView.subviews lastObject].frame) + 15.f, 0);
    }
}

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    
    if (selectedBtn == _selectedBtn) {
        
        return;
    }
    
    CGFloat originX = selectedBtn.center.x - CGRectGetMidX(self.scrollView.frame);
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    
    if (originX < 0) {
        
        originX = 0;
    }else if (originX > maxOffsetX) {
        
        originX = maxOffsetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(originX, 0) animated:YES];
    [self.selectedBtn setTitleColor:[UIColor colorWithRed:104/255.0 green:104/255.0 blue:124/255.0 alpha:1.f] forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor colorWithRed:49/255.0 green:195/255.0 blue:124/255.0 alpha:1.f] forState:UIControlStateNormal];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithFloat:1.2f];
    animation1.toValue  = [NSNumber numberWithFloat:1.0f];
    animation1.duration = 0.3;
    animation1.repeatCount = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.autoreverses = NO;
    [self.selectedBtn.titleLabel.layer addAnimation:animation1 forKey:@"animation1"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:1.0f];
    animation2.toValue  = [NSNumber numberWithFloat:1.2f];
    animation2.duration = 0.3;
    animation2.repeatCount = 1;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    animation2.autoreverses = NO;
    [selectedBtn.titleLabel.layer addAnimation:animation2 forKey:@"animation2"];
    
    _selectedBtn = selectedBtn;
   
}

- (void)menuBtnClick:(UIButton *)sender {
    
    if (self.selectedBtn == sender) {
        return;
    }
    
    self.selectedBtn = sender;
    if ([self.delegate respondsToSelector:@selector(menuBtnClick:)]) {
        
        [self.delegate menuBtnClickAtIndex:sender.tag - tagIndex];
    }
}

@end
