//
//  NSDate+DateCategory.m
//  DatePickerDemo
//

#import "NSDate+DateCategory.h"

@implementation NSDate (DateCategory)


/**
 To get the year of the date

 @return year of date
 */
- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

/**
 To get the month of the date
 
 @return month of date
 */
- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

/**
 To get the day of the date
 
 @return day of date
 */
- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return components.day;
}


/**
 To get the date for a year, month and day.

 @param year the year data
 @param month the month data
 @param day the day data
 @return the date created using the year, month and day data.
 */
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
