//
//  MyView.h
//  LianXi001
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewDelegate <NSObject>

@optional

- (void)menuBtnClickAtIndex:(NSInteger)index;

@end

@interface MyView : UIView

@property(nonatomic,weak) id <MyViewDelegate> delegate;

@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,strong)NSMutableArray *menuArray;
@property(nonatomic,assign)BOOL  isShowBreakLIne;

- (void)setBreaklineColor:(UIColor *)color;
- (void)setselectedIndex:(NSInteger)index;

@end
