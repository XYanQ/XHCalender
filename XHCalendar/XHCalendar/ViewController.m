//
//  ViewController.m
//  XHCalendar
//
//  Created by sun on 2017/3/14.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "ViewController.h"
#import "XHCalenderView.h"
#import "XHCalendarTool.h"
#define NOW [NSDate date]
#define SIZE [UIScreen mainScreen].bounds.size
@interface ViewController (){
    XHCalenderView *calendarsView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    calendarsView = [[XHCalenderView alloc]init];
    calendarsView.frame = CGRectMake(0, 40, SIZE.width, 300);
    calendarsView.date = NOW;
    calendarsView.signArray = @[@"1",@"3",@"4"];
    [self.view addSubview:calendarsView];
    
    calendarsView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        
       
        NSLog(@"点击了");
        
    };

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
