//
//  ARShell.h
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "Constants.h"
#import "ARActivity.h"
#import "Markov.h"
#import "ARShellProtocol.h"

@interface ARShell : NSObject {
    CMMotionActivityManager *manager;
}

@property id<ARShellProtocol> delegate;

-(void)start;
-(void)startAll;
-(void)startFromDate:(NSDate *)_startDate toEndDate:(NSDate *)_endDate;
-(void)stop;

@end
