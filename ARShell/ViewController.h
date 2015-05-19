//
//  ViewController.h
//  ARShell
//
//  Created by Sushank N Rao on 4/1/15.
//  Copyright (c) 2015 Sushank N Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARShell.h"
#import "ARShellProtocol.h"

@interface ViewController : UIViewController <ARShellProtocol> {
    ARShell *arshell;
}

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
- (IBAction)logs:(id)sender;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@end

