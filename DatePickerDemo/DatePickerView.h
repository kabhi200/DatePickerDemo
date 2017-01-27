//
//  DatePickerView.h
//  DatePickerDemo
//
//  Created by Abhishek Kumar on 27/01/17.
//  Copyright © 2017 Abhishek Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)pickerDidSelectDate:(NSDate *)date;
@end

@interface DatePickerView : UIView

@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

- (id)initWithBeginDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
