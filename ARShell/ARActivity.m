//
//  ARActivity.m
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import "ARActivity.h"

@implementation ARActivity

@synthesize date,confidence,primaryActivity,secondaryActivity;

-(ARActivity *)convertActivity:(CMMotionActivity *)activity {
    date = activity.startDate;
    confidence = activity.confidence;
    primaryActivity = secondaryActivity = -1;
    
    if (activity.stationary) {
        primaryActivity = 0;
    }
    if (activity.walking) {
        if (primaryActivity == -1) {
            primaryActivity = 1;
        } else {
            secondaryActivity = primaryActivity;
            primaryActivity = 1;
        }
    }
    if (activity.running) {
        if (primaryActivity == -1) {
            primaryActivity = 2;
        } else {
            secondaryActivity = primaryActivity;
            primaryActivity = 2;
        }
    }
    if (activity.automotive) {
        if (primaryActivity == -1) {
            primaryActivity = 3;
        } else {
            secondaryActivity = primaryActivity;
            primaryActivity = 3;
        }
    }
    if (activity.cycling) {
        if (primaryActivity == -1) {
            primaryActivity = 4;
        } else {
            secondaryActivity = primaryActivity;
            primaryActivity = 4;
        }
    }
    if (activity.unknown) {
        if (primaryActivity == -1) {
            primaryActivity = 5;
        } else {
            secondaryActivity = 5;
        }
    }
    return self;
}

@end
