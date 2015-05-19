//
//  Markov.h
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "ARActivity.h"

@interface Markov : NSObject {
    int state;
    int threshold;
    Boolean firstTime;
    int prevConfidence;
    int primaryState,secondaryState;
}

-(ARActivity *)getMarkovPredictionResult:(ARActivity *)activity;

@end
