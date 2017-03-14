//
//  XHCalenderView.h
//  XHCalendar
//
//  Created by sun on 2017/3/14.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHCalenderView : UIView
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);
@property (nonatomic,strong)  NSArray *signArray;


//今天
@property (nonatomic,strong)  UIButton *dayButton;
- (void)setStyle_Today_Signed:(UIButton *)btn;
- (void)setStyle_Today:(UIButton *)btn;
@end
