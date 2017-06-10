//
//  ViewController.m
//  TipCalculator
//
//  Created by Harry Li on 2017-06-09.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSlider;


@property (weak, nonatomic) NSString *billAmount;
@property (weak, nonatomic) NSString *tipPercentage;
@property (weak, nonatomic) NSString *tipAmount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tipPercentSlider.maximumValue = 100;
    self.tipPercentSlider.minimumValue = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdatedData:) name:@"DataUpdated" object:nil];
}

- (void)handleUpdatedData:(NSNotification *)notification{
    [self calculateTip];
    self.tipAmountLabel.text = self.tipAmount;
}

- (void)calculateTip{
    self.tipAmount = [NSString stringWithFormat:@"$%.2f", self.billAmount.floatValue * self.tipPercentage.floatValue/100.0];
}

- (IBAction)billAmountEditingChanged:(UITextField *)sender {
    self.billAmount = sender.text;
}
- (IBAction)tipPercentageTextField:(UITextField *)sender {
    self.tipPercentage = sender.text;
}

- (IBAction)tipPercentSliderValueChanged:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.0f", sender.value];
    self.tipPercentage = [NSString stringWithFormat:@"%f", sender.value];
    self.tipPercentage = self.tipPercentageTextField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataUpdated" object:nil];
}

- (IBAction)calculateTipButtonPressed:(UIButton *)sender {
    [self calculateTip];
    self.tipAmountLabel.text = self.tipAmount;
}
- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
