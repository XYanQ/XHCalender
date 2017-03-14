//
//  XHCalenderView.m
//  XHCalendar
//
//  Created by sun on 2017/3/14.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "XHCalenderView.h"
#import "XHCalendarTool.h"
@implementation XHCalenderView{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.height / 7;
    CGFloat itemH     = self.frame.size.height / 7;
    CGFloat itemSpace = (self.frame.size.width - 300)/8;
    // self.backgroundColor= [UIColor redColor]
    // 1.year month
    //    UILabel *headlabel = [[UILabel alloc] init];
    //    headlabel.text     = [NSString stringWithFormat:@"%li-%li",[HYCalendarTool year:date],[HYCalendarTool month:date]];
    //    headlabel.font     = [UIFont systemFontOfSize:14];
    //    headlabel.frame           = CGRectMake(0, 0, self.frame.size.width, itemH);
    //    headlabel.textAlignment   = NSTextAlignmentCenter;
    //    [self addSubview:headlabel];
    
    // 2.weekday
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    UIView *weekBg = [[UIView alloc] init];
    weekBg.backgroundColor = [UIColor clearColor];
    weekBg.frame = CGRectMake(0, 0, self.frame.size.width, itemH);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:17];
        week.frame    = CGRectMake(itemW * i + itemSpace*(i+1), 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = [UIColor lightGrayColor];
        [weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW + itemSpace *((i % 7)+1);
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x, y, itemW, itemH);
        
        dayButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        //        dayButton.layer.cornerRadius = dayButton.frame.size.height/2;
        //        dayButton.layer.masksToBounds = YES;
        // dayButton.backgroundColor = [UIColor redColor];
        dayButton.enabled = NO;
        //  [dayButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [XHCalendarTool totaldaysInMonth:[XHCalendarTool lastMonth:date]];
        NSInteger daysInThisMonth = [XHCalendarTool totaldaysInMonth:date];
        NSInteger firstWeekday    = [XHCalendarTool firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        // this month
        if ([XHCalendarTool month:date] == [XHCalendarTool month:[NSDate date]]) {
            
            NSInteger todayIndex = [XHCalendarTool day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                [self setStyle_BeforeToday:dayButton];
                
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
                _dayButton = dayButton;
            }
        }
        
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
            [self setSign:day andBtn:dayButton];
            
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
    }
}


#pragma mark 设置已经签到
- (void)setSign:(NSInteger)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSInteger now = i;
        int now2 = [obj intValue];
        if (now2== now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}

#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    _selectButton.selected = NO;
    dayBtn.selected = YES;
    _selectButton = dayBtn;
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
}


#pragma mark - date button style
//设置不是本月的日期字体颜色   ---灰色
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

//这个月 今日之前的日期style
- (void)setStyle_BeforeToday:(UIButton *)btn
{
    btn.enabled = NO;
 
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

//今日已签到
- (void)setStyle_Today_Signed:(UIButton *)btn
{
    btn.enabled = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor orangeColor]];
}

//今日没签到
- (void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    //    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setBackgroundImage:[UIImage imageNamed:@"今天未"] forState:UIControlStateNormal];
}

//这个月 今天之后的日期style
- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"礼物"] forState:UIControlStateNormal];
}

@end
