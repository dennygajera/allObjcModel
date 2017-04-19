//
//  popOverViewController.h
//  CalenderInObjectiveC
//
//  Created by peacock on 22/09/15.
//  Copyright (c) 2015 peacock. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface popOverViewController : UIViewController<FSCalendarDataSource, FSCalendarDelegate>
@property (strong, nonatomic) IBOutlet FSCalendar *calendar;
@property (nonatomic,retain)NSString *Date;
@end
