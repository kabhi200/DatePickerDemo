//
//  NSDate+DateCategory.m
//  DatePickerDemo
//
//  Created by Abhishek Kumar on 27/01/17.
//  Copyright © 2017 Abhishek Kumar. All rights reserved.
//

#import "NSDate+DateCategory.h"

@implementation NSDate (DateCategory)

- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *createdDate = [calendar dateFromComponents:comps];
    return createdDate;
}

@end
