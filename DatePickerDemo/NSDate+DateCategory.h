//
//  NSDate+DateCategory.h
//  DatePickerDemo
//

#import <Foundation/Foundation.h>

@interface NSDate (DateCategory)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

@end
