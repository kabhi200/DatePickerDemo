//
//  DatePickerViewController.m
//  DatePickerDemo
//

#import "DatePickerViewController.h"
#import "DatePickerView.h"
#import "NSDate+DateCategory.h"

@interface DatePickerViewController ()<DatePickerViewDelegate>

@property(nonatomic, weak) IBOutlet UILabel *dateLbl;

@end

#define ONE_DAY    60*60*24 // This is equivalent to 1 day.

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpDatePickerView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 To set the date picker view from start date to end date.
 */
-(void)setUpDatePickerView
{
    NSDate *beginDate = [NSDate date];
    
    // To set the range of Date Picker from Current Date.
    NSTimeInterval aTimeInterval = [NSDate timeIntervalSinceReferenceDate] + ONE_DAY * (365*20);
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    DatePickerView *datePicker = [[DatePickerView alloc] initWithBeginDate:beginDate endDate:endDate];
    CGPoint origin = datePicker.frame.origin;
    datePicker.delegate = self;
    datePicker.frame = (CGRect){origin.x, origin.y+20, datePicker.frame.size};
    [self.view addSubview:datePicker];

    NSInteger year = [beginDate year];
    NSInteger month = [beginDate month];
    NSInteger day = [beginDate day];

    self.dateLbl.text = [NSString stringWithFormat:@"%ld/%02ld/%ld", (long)month, (long)day, (long)year];

}

#pragma mark - DatePickerViewDelegate

/**
 DatePickerViewDelegate method to get the selected date.

 @param date the NSDate object
 */
- (void)pickerDidSelectDate:(NSDate *)date{
    NSInteger year = [date year];
    NSInteger month = [date month];
    NSInteger day = [date day];
    self.dateLbl.text = [NSString stringWithFormat:@"%ld/%02ld/%ld", (long)month, (long)day, (long)year];
}

@end
