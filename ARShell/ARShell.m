//
//  ARShell.m
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import "ARShell.h"

@implementation ARShell

@synthesize delegate;

-(ARShell *) init {
    self = [super init];
    if (self) {
        manager = [CMMotionActivityManager new];
    }
    return self;
}


-(void)start {
    if ([CMMotionActivityManager isActivityAvailable]) {
        NSLog(@"Motion Activity Available");
        [manager startActivityUpdatesToQueue:[NSOperationQueue new]
                                 withHandler:^(CMMotionActivity *activity) {
                                     if ([self trimActivity:activity]) {
                                         ARActivity *activityConverter = [ARActivity new];
                                         ARActivity *convertedActivity = [activityConverter convertActivity:activity];
                                         Markov *activityPredictor = [Markov new];
                                         ARActivity *predictedActivity = [activityPredictor getMarkovPredictionResult:convertedActivity];
                                         NSArray *result = [[NSArray alloc] initWithObjects:convertedActivity, predictedActivity, nil];
                                         [delegate ActivityUpdate:result];
                                         
                                     } else {
                                         NSLog(@"Contigous activity");
                                     }
                                 }];
    }
    else {
        NSLog(@"Motion Activity NOT Available");
    }
}

-(void)startAll {
    if ([CMMotionActivityManager isActivityAvailable]) {
        NSLog(@"Motion Activity Available");
        [self getActivityDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-7*24*60*60] toDate:[NSDate new]];
    }
    else {
        NSLog(@"Motion Activity NOT Available");
    }
}


-(void)startFromDate:(NSDate *)_startDate toEndDate:(NSDate *)_endDate {
    if ([CMMotionActivityManager isActivityAvailable]) {
        NSLog(@"Motion Activity Available");
        [self getActivityDataFromDate:_startDate toDate:_endDate];
    }
    else {
        NSLog(@"Motion Activity NOT Available");
    }
}

-(void)stop {
    [manager stopActivityUpdates];
}


-(void)getActivityDataFromDate:(NSDate *)_startDate toDate:(NSDate *)_endDate{
    [manager queryActivityStartingFromDate:_startDate toDate:_endDate
                                   toQueue:[NSOperationQueue new]
                               withHandler:^(NSArray *activities, NSError *error){
                                   NSLog(@"%lu Activities Detected",(unsigned long)[activities count]);
                                   NSArray *trimmedActivities = [self trimActivityList:activities];
                                   NSLog(@"%lu Activities Trimmed",(unsigned long)[activities count]-(unsigned long)[trimmedActivities count]);
                                   NSArray *convertedActivities = [self convertActivities:trimmedActivities];
                                   NSLog(@"%lu Activities Converted",(unsigned long)[convertedActivities count]);
                                   NSArray *predictedActivities = [self predictActivities:convertedActivities];
                                   NSLog(@"%lu Activities Predicted",(unsigned long)[predictedActivities count]);
                                   [self writeToLog:convertedActivities fileName:@"default.log"];
                                   [self writeToLog:predictedActivities fileName:@"predicted.log"];

    }];
}

-(Boolean) trimActivity:(CMMotionActivity *) activity {
    Boolean flag = false;
    if (activity.stationary) {
        flag = true;
    }
    if (activity.walking) {
        flag = true;
    }
    if (activity.running) {
        flag = true;
    }
    if (activity.automotive) {
        flag = true;
    }
    if (activity.cycling) {
        flag = true;
    }
    if (activity.unknown) {
        flag = true;
    }
    return flag;
}


-(NSArray *)trimActivityList:(NSArray *)activities {
    NSMutableArray *trimmedArray = [[NSMutableArray alloc] init];
    Boolean flag = false;
    for (CMMotionActivity *activity in activities) {
        if (activity.stationary) {
            flag = true;
        }
        if (activity.walking) {
            flag = true;
        }
        if (activity.running) {
            flag = true;
        }
        if (activity.automotive) {
            flag = true;
        }
        if (activity.cycling) {
            flag = true;
        }
        if (activity.unknown) {
            flag = true;
        }
        if (flag) {
            [trimmedArray addObject:activity];
            flag = false;
        }
    }
    return trimmedArray;
};

-(NSArray *)convertActivities:(NSArray *)activities {
    NSMutableArray *convertedActivities = [NSMutableArray new];
    for (CMMotionActivity *activity in activities) {
        ARActivity *newActivity = [ARActivity new];
        [convertedActivities addObject:[newActivity convertActivity:activity]];
//        NSLog(@"Date: %@ Confidence: %d Primary:%d Secondary:%d",newActivity.date,newActivity.confidence,newActivity.primaryActivity,newActivity.secondaryActivity);
    }
    
    return convertedActivities;
};

-(NSArray *)predictActivities:(NSArray *)activities {
    NSMutableArray *predictedActivities = [NSMutableArray new];
    for (ARActivity *activity in activities) {
        Markov *mk = [Markov new];
        [predictedActivities addObject:[mk getMarkovPredictionResult:activity]];
    }
    
//    for (ARActivity *newActivity in predictedActivities) {
//        NSLog(@"Date: %@ Confidence: %d Primary:%d Secondary:%d",newActivity.date,newActivity.confidence,newActivity.primaryActivity,newActivity.secondaryActivity);        
//    }
    
    return predictedActivities;
}

-(void)writeToLog:(NSArray *)activities fileName:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:filename];
    NSString *content;
    NSMutableArray *text = [NSMutableArray new];
    for (ARActivity *activity in activities) {
        content = [NSString stringWithFormat:@"%@,%d,%d,%d\n",activity.date,activity.confidence,activity.primaryActivity,activity.secondaryActivity];
        [text addObject:content];
    }
    [text writeToFile:fileName atomically:NO];
}


@end
