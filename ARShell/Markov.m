//
//  Markov.m
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import "Markov.h"

@implementation Markov

-(Markov *)init {
    self = [super init];
    if (self) {
        state = 5;
        threshold = 2;
        firstTime = true;
        prevConfidence = 0;
        primaryState = secondaryState = -1;
    }
    return self;
}

-(ARActivity *)getMarkovPredictionResult:(ARActivity *)activity {
    ARActivity *predictedActivity = [ARActivity new];
    predictedActivity.date = activity.date;
    predictedActivity.confidence = activity.confidence;
    predictedActivity.primaryActivity = [self predict:activity];
    predictedActivity.secondaryActivity = -1;
    return predictedActivity;
}

-(int)predict:(ARActivity *)activity {
    int returnState = 0;
    if (activity.primaryActivity == 5) {
        returnState = state;
    } else if (state != activity.primaryActivity) {
        if (state == 5) {
            [self copy:activity];
            state = activity.primaryActivity;
            returnState = state;
        } else {
            if (activity.confidence > prevConfidence) {
                [self copy:activity];
                state = activity.primaryActivity;
                returnState = state;
            } else {
                if (firstTime) {
                    [self copy:activity];
                    firstTime = false;
                }
                if (primaryState == activity.primaryActivity) {
                    state = activity.primaryActivity;
                    returnState = state;
                } else if (secondaryState == activity.primaryActivity) {
                    state = activity.primaryActivity;
                    returnState = state;
                } else if (secondaryState == activity.secondaryActivity){
                    state = activity.secondaryActivity;
                    [self copy:activity];
                    returnState = state;
                } else {
                    if (activity.confidence == 2) {
                        state = activity.primaryActivity;
                    }
                    returnState = state;
                }
            }
        }
        
    } else {
        if (!firstTime) {
            firstTime = true;
        }
        [self copy:activity];
        returnState = state;
    }
    
    
    
    return returnState;
};

-(void)copy:(ARActivity *) activity {
    prevConfidence = activity.confidence;
    primaryState = activity.primaryActivity;
    secondaryState = activity.secondaryActivity;
}

@end


