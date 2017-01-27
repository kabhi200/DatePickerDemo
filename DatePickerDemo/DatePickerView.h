//
//  DatePickerView.h
//  DatePickerDemo
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)pickerDidSelectDate:(NSDate *)date;
@end

@interface DatePickerView : UIView

@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

- (id)initWithBeginDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
