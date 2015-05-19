//
//  ViewController.m
//  ARShell
//
//  Created by Sushank N Rao on 4/1/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label1,label2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arshell = [[ARShell alloc] init];
    [arshell setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ActivityUpdate:(NSArray *)_Activities {
    ARActivity *given = [_Activities objectAtIndex:0];
    ARActivity *predicted = [_Activities objectAtIndex:1];
    NSString *givenactivity = [self action:given.primaryActivity];
    NSString *predictedactivity = [self action:predicted.primaryActivity];
    NSString *givenString = [NSString stringWithFormat:@"Date: %@\nConfidence:%d Activity:%@"
                             ,given.date,given.confidence,givenactivity];
    NSString *predictedString = [NSString stringWithFormat:@"Date: %@\nConfidence:%d Activity:%@"
                                 ,predicted.date,predicted.confidence,predictedactivity];
    label1.text = givenString;
    label1.numberOfLines = 0;
    label2.text = predictedString;
    label2.numberOfLines = 0;
    
}

- (IBAction)logs:(id)sender {
    
    [arshell startAll];
}

- (IBAction)start:(id)sender {
    [arshell start];
}

- (IBAction)stop:(id)sender {
    [arshell stop];
}

-(NSString*)action:(int)value {
    NSString *returnValue;
    switch (value) {
        case 0:
            returnValue = @"Stationary";
            break;
        case 1:
            returnValue = @"Walking";
            break;
        case 2:
            returnValue = @"Running";
            break;
        case 3:
            returnValue = @"Automotive";
            break;
        case 4:
            returnValue = @"Cycling";
            break;
        case 5:
            returnValue  = @"Unknown";
            break;
        default:
            returnValue = @"Error";
            break;
    }
    return returnValue;
}

@end
