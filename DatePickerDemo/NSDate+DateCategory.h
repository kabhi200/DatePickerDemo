//
//  NSDate+DateCategory.h
//  DatePickerDemo
//
//  Created by Abhishek Kumar on 27/01/17.
//  Copyright © 2017 Abhishek Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateCategory)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

@end
