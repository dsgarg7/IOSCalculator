//
//  ViewController.m
//  Test
//
//  Created by DEEP S GARG on 02/01/17.
//  Copyright © 2017 DEEP S GARG. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController () {
    int final;
    int current;
    int op;
}

@property (nonatomic, strong) NSString *s;
@property (weak, nonatomic) IBOutlet UILabel *LabelOutput;


- (IBAction)Btn0:(id)sender;
- (IBAction)BtnDot:(id)sender;
- (IBAction)BtnAC:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)Load:(id)sender;
- (void)calc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    current = 0;
    final = 0;
    op = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Btn0:(id)sender {
    self.LabelOutput.text = [(UIButton *)sender currentTitle];

    
     NSString *outputNumber = self.LabelOutput.text;
     current = current * 10 + [outputNumber intValue];
     self.LabelOutput.text = [NSString stringWithFormat:@"%d", current];

}




- (IBAction)BtnDot:(id)sender {
}
- (IBAction)BtnAC:(id)sender {
    
    self.LabelOutput.text=@"0";
    final = 0;
    current = 0;
    op=5;
    
}

- (IBAction)Save:(id)sender {
    NSString *valueToSave = self.LabelOutput.text;
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"result"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)Load:(id)sender {
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"result"];
    self.LabelOutput.text =  savedValue;
}

- (IBAction)BtnOperation:(id)sender {
    NSString *outputNumber = self.LabelOutput.text;
    current =  [outputNumber intValue];
    [self calc];
    current = 0;
    self.s = [(UIButton *)sender currentTitle];
    if([self.s isEqual: @"/"])
        op = 3;
    if([self.s isEqual: @"+"])
        op = 1;
    if([self.s isEqual: @"-"])
        op = 2;
    if([self.s isEqual: @"x"])
        op = 4;
    
}

- (void)calc {
    
    switch(op){
        case 1  :
            current = final + current;
            break; /* optional */
        case 2  :
            current = final - current;
            break; /* optional */
        case 3  :
            current = final / current;
            break; /* optional */
        case 4  :
            current = final * current;
            break; /* optional */
            
            /* you can have any number of case statements */
        default :
            
            
            ; /* Optional */
            final = current;
            
    }
    self.LabelOutput.text = [NSString stringWithFormat:@"%d", current];

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultTransfer"]) {
        ViewController2 *destViewController = segue.destinationViewController;
         [self calc];
        destViewController.result = self.LabelOutput.text;
    }
}

@end
