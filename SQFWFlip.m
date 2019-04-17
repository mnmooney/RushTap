//
//  SQFWFlip.m
//  Colour Tap
//
//  Created by Michael Mooney on 21/02/2015.
//  Copyright (c) 2015 Michael Mooney. All rights reserved.
//

#import "SQFWFlip.h"

@implementation SQFWFlip

-(void)perform
{
    UIViewController* source = (UIViewController *)self.sourceViewController;
    UIViewController* destination = (UIViewController *)self.destinationViewController;
    
    CGRect sourceFrame = source.view.frame;
    sourceFrame.origin.y = sourceFrame.size.width;
    
    CGRect destFrame = destination.view.frame;
    destFrame.origin.y = -destination.view.frame.size.width;
    destination.view.frame = destFrame;
    
    destFrame.origin.y = 0;
    
    [source.view.superview addSubview:destination.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         source.view.frame = sourceFrame;
                         destination.view.frame = destFrame;
                     }
                     completion:^(BOOL finished) {
                         UIWindow *window = source.view.window;
                         [window setRootViewController:destination];
                     }];
}

@end
