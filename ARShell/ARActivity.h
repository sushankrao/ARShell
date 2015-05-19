//
//  ARActivity.h
//  ARShell
//
//  Created by Sushank N Rao on 4/26/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ARActivity : NSObject
@property NSDate *date;
@property int confidence;
@property int primaryActivity;
@property int secondaryActivity;


-(ARActivity *)convertActivity:(CMMotionActivity *)activity;

@end
