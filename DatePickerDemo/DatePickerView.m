//
//  DatePickerView.m
//  DatePickerDemo
//

#import "DatePickerView.h"
#import "NSDate+DateCategory.h"

#define kWinSize [UIScreen mainScreen].bounds.size

const NSUInteger kYearComponent = 0;
const NSUInteger kMonthComponent = 1;
const NSUInteger kDayComponent = 2;

@interface DatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    
    NSMutableArray *monthsArr;
    NSMutableArray *daysArr;
    NSMutableArray *yearsArr;
    
    NSNumber *yearNumber;
    NSNumber *monthNumber;
    NSNumber *dayNumber;
}

@property (nonatomic) NSDate *beginDate;
@property (nonatomic) NSDate *endDate;

@property (nonatomic) NSDate *date;
@property (nonatomic) UIPickerView *datePicker;

@end

@implementation DatePickerView

#pragma mark - Init


/**
 Initialize the Picker view with begin date and end date.

 @param startDate start date of the picker view
 @param endDate end date of the picker view
 @return return the Picker view object
 */
- (id)initWithBeginDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];
    if (self) {
        self.date = startDate;
        
        self.beginDate = startDate;
        self.endDate = endDate;
        
        [self setUpMonthsAndYearComponent];
        
        self.frame = CGRectMake(0.0, 0.0, kWinSize.width, 216.0);
        CGRect datePickerFrame = self.frame;
        
        self.datePicker = [[UIPickerView alloc] initWithFrame: datePickerFrame];
        self.datePicker.dataSource = self;
        self.datePicker.delegate = self;
        [self addSubview: self.datePicker];
        
        [self setupComponentsFromDate: startDate];
    }
    return self;
}


/**
 To set the month and year data.
 */
-(void)setUpMonthsAndYearComponent
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    monthsArr = [[NSMutableArray alloc] init];
    yearsArr = [[NSMutableArray alloc] init];
    daysArr = [[NSMutableArray alloc] init];

    [dateFormatter setDateFormat: @"MMMM"];
    dateComponents.month = 1;
    
    for (NSInteger i = 1; i <= 12; i++) {
        [monthsArr addObject: [dateFormatter stringFromDate: [calendar dateFromComponents: dateComponents]]];
        dateComponents.month++;
    }
    
    for (NSInteger year = [self.beginDate year]; year <= [self.endDate year]; year++) {
        [yearsArr addObject: @(year)];
    }
}


/**
 To setup the day component.

 @param startDate the start date
 */
- (void)setupComponentsFromDate:(NSDate *)startDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger currentYear = [calendar components: NSCalendarUnitYear fromDate: [NSDate date]].year;
    
    NSInteger beginYear = [startDate year];
    
    if (currentYear < beginYear)
        yearIndex = [yearsArr indexOfObject: [NSString stringWithFormat: @"%lu", (unsigned long)beginYear]];
    else
        yearIndex = [yearsArr indexOfObject: @(currentYear)];
    
    monthIndex = [calendar components: NSCalendarUnitMonth fromDate: [NSDate date]].month - 1;
    dayIndex = [calendar components: NSCalendarUnitDay fromDate: [NSDate date]].day;
    
    NSDateComponents *dateComponents = [calendar components: NSCalendarUnitMonth | NSCalendarUnitYear fromDate: startDate];
    
    if (beginYear < [yearsArr[yearIndex] integerValue]) {
        if (dateComponents.year == yearIndex) {
            if (dateComponents.month >= monthIndex) {
                monthIndex = dateComponents.month - 1;
            }
            yearIndex = [yearsArr indexOfObject: @(dateComponents.year)];
        }
        else {
            yearIndex = [yearsArr indexOfObject: @(dateComponents.year)];
            monthIndex = dateComponents.month - 1;
        }
    }
    
    NSInteger dayLenth = [self daysForMonth:monthIndex inYear:[yearsArr[yearIndex] intValue]];
    
    for (NSInteger day = 1; day < dayLenth+1; day++) {
        [daysArr addObject:@(day)];
    }
    
    [self.datePicker selectRow: yearIndex
               inComponent: 0
                  animated: YES];
    [self.datePicker selectRow: monthIndex
               inComponent: 1
                  animated: YES];
    [self.datePicker selectRow: dayIndex
               inComponent: 2
                  animated: YES];
    
    yearNumber = yearsArr[yearIndex];
    monthNumber = monthsArr[monthIndex];

}


/**
 To return the number of days in leap year or common year

 @param monthData the month data
 @param yearData the year data
 @return the number of days
 */
-(NSInteger)daysForMonth:(NSInteger)monthData inYear:(NSInteger)yearData
{
    NSMutableArray *daysForYear = [[NSMutableArray alloc] initWithObjects:@"31", @"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    
    if (monthData == 1) {
        if ((yearData%4 == 0))
            return 29;
        else
            return 28;
    }
    else
        return [[daysForYear objectAtIndex:monthData] integerValue];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30.0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            return yearsArr.count;
        }
            break;
        case 1: {
            return monthsArr.count;
        }
            break;
        case 2: {
            return daysArr.count;
        }
            break;
        default:
            break;
    }
    
    return 0;
    
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize: 22.0];
    
    switch (component) {
        case kYearComponent:{
            label.text = [NSString stringWithFormat: @"%@", yearsArr[row]];
            label.frame = CGRectMake(kWinSize.width * 0.5, 0, kWinSize.width * 0.5, 30.0);
        }
            break;
        case kMonthComponent:{
            label.text = [NSString stringWithFormat: @"%@", monthsArr[row]];
            label.frame = CGRectMake(0, 0, kWinSize.width * 0.5, 30.0);
        }
            break;
        case kDayComponent:{
            label.text = [NSString stringWithFormat: @"%@", daysArr[row]];
            label.frame = CGRectMake(0, 0, kWinSize.width * 0.5, 30.0);
        }
        default:
            break;
    }
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.bounds.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case kDayComponent:{
            dayIndex = [self.datePicker selectedRowInComponent: kDayComponent];
        }
            break;
        case kMonthComponent: {
            monthIndex = [self.datePicker selectedRowInComponent: kMonthComponent];
        }
            break;
        case kYearComponent: {
            yearIndex = [self.datePicker selectedRowInComponent: kYearComponent];
        }
            break;
        default:
            break;
    }
    
    yearNumber = yearsArr[yearIndex];
    monthNumber = monthsArr[monthIndex];
    dayNumber = daysArr[dayIndex];
    
    NSDate *selectedDate = [NSDate dateWithYear:[yearNumber intValue] month:monthIndex+1 day:[dayNumber intValue]];
    
    if ([self.beginDate compare:selectedDate] == NSOrderedDescending)
    {
        monthIndex = [self.beginDate month]-1;
        dayIndex = [self.beginDate day]-1;
    }
    else if ([self.endDate compare:selectedDate] == NSOrderedAscending)
    {
        monthIndex = [self.endDate month]-1;
        dayIndex = [self.endDate day]-1;
    }
    
    [pickerView selectRow:monthIndex inComponent:kMonthComponent animated:YES];
    [pickerView selectRow:dayIndex inComponent:kDayComponent animated:YES];
    
    daysArr = [NSMutableArray new];
    NSInteger dayLenth = [self daysForMonth:monthIndex inYear:[yearsArr[yearIndex] intValue]];
    
    for (NSInteger day = 1; day < dayLenth+1; day++) {
        [daysArr addObject:@(day)];
    }
    [self.datePicker reloadComponent:kDayComponent];
    
    if (dayIndex > dayLenth-1) {
        dayIndex = dayLenth-1;
        [self.datePicker selectRow:dayLenth-1 inComponent:kDayComponent animated:YES];
    }
    
    yearNumber = yearsArr[yearIndex];
    monthNumber = monthsArr[monthIndex];
    dayNumber = daysArr[dayIndex];
    
    self.date = [NSDate dateWithYear:[yearNumber intValue] month:monthIndex+1 day:[dayNumber intValue]];
    
    if ([self.delegate respondsToSelector: @selector(pickerDidSelectDate:)])
        [self.delegate pickerDidSelectDate:self.date];
}


@end
