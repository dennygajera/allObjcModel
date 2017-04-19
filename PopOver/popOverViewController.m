//
//  popOverViewController.m
//  CalenderInObjectiveC
//
//  Created by peacock on 22/09/15.
//  Copyright (c) 2015 peacock. All rights reserved.
//

#import "popOverViewController.h"
#import "NSDate+FSExtension.h"

@interface popOverViewController ()

@end

@implementation popOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calendar.delegate = self;
    _calendar.dataSource = self;
    _calendar.selectedDate = [[NSDate alloc]init];
    _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    _calendar.scope = FSCalendarScopeMonth;
}
-(BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
{
    return date.fs_day == 5;
}

-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [format stringFromDate:date];
    
    _Date = dateString;
    
   // _Date = date.fs_string;
   // NSLog(@"%@",_Date);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
