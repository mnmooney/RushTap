//
//  APPViewController.m
//  Colour Tap
//
//  Created by Michael Mooney on 21/02/2015.
//  Copyright (c) 2015 Michael Mooney. All rights reserved.
//

#import "APPViewController.h"
#import "ViewController.h"

@interface APPViewController ()

@end

@implementation APPViewController

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Birght = [[NSUserDefaults standardUserDefaults] integerForKey:@"BrightnessSaved"];
    if (Birght == 0) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    } else if (Birght == 1) {
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    [self performSelector:@selector(Flippping) withObject:nil afterDelay:0.4];
    
    
}

-(void)Flippping
{
    [self performSegueWithIdentifier:@"FWFlip" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
