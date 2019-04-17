//
//  ViewController.m
//  Colour Tap
//
//  Created by Michael Mooney on 07/02/2015.
//  Copyright (c) 2015 Michael Mooney. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

CGPoint pOne, pTwo, pThree, pFour, pFive, pSix, pSeven, pEight;
int randomNumber;
int Score, harder;
double Time;
BOOL GameOver, Other;
NSInteger HighScoreN;
@interface ViewController () <ADBannerViewDelegate, AVAudioPlayerDelegate>
{
    IBOutlet UIImageView *MiddleButton;
    NSTimer *theTimer;
    IBOutlet UILabel *inGameScore, *HighScore, *FinalScore, *inGameTimer, *One, *Two;
    IBOutlet UIImageView *Red, *Blue, *Yellow, *Green, *Purple, *Silver, *Cyan, *Orange;
    IBOutlet UIButton *Replay, *Brightness;
    NSTimer *Faster;
}
@property (nonatomic, retain) AVAudioPlayer *SoundOne, *SoundTwo, *SoundThree, *SoundFour;
@property (strong, nonatomic)IBOutlet ADBannerView *Banner;
@end

@implementation ViewController

-(void)authentication
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                NSLog(@"authentication succcesful");
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            else{
                NSLog(@"authentication unseuccseful");
            }
        }
    };
}

-(void)reportScore
{
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"Colour_Tap_Leaderboard"];
    int64_t GameCenterScoreFour = HighScoreN;
    score.value = GameCenterScoreFour;
 
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight == 480) {
        Red = [[UIImageView alloc] initWithFrame:CGRectMake(2, 402, 70, 70)];
        Blue = [[UIImageView alloc] initWithFrame:CGRectMake(85, 402, 70, 70)];
        Green = [[UIImageView alloc] initWithFrame:CGRectMake(166, 402, 70, 70)];
        Yellow = [[UIImageView alloc] initWithFrame:CGRectMake(249, 402, 70, 70)];
        
        Orange = [[UIImageView alloc] initWithFrame:CGRectMake(2, 322, 70, 70)];
        Purple = [[UIImageView alloc] initWithFrame:CGRectMake(85, 322, 70, 70)];
        Cyan = [[UIImageView alloc] initWithFrame:CGRectMake(166, 322, 70, 70)];
        Silver = [[UIImageView alloc] initWithFrame:CGRectMake(249, 322, 70, 70)];
        
        MiddleButton = [[UIImageView alloc] initWithFrame:CGRectMake(85, 155, 150, 150)];
        Replay = [[UIButton alloc] initWithFrame:CGRectMake(85, 155, 150, 150)];
        
    } else if (screenHeight == 568) {
        Red = [[UIImageView alloc] initWithFrame:CGRectMake(2, 490, 70, 70)];
        Blue = [[UIImageView alloc] initWithFrame:CGRectMake(85, 490, 70, 70)];
        Green = [[UIImageView alloc] initWithFrame:CGRectMake(166, 490, 70, 70)];
        Yellow = [[UIImageView alloc] initWithFrame:CGRectMake(249, 490, 70, 70)];
        
        Orange = [[UIImageView alloc] initWithFrame:CGRectMake(2, 400, 70, 70)];
        Purple = [[UIImageView alloc] initWithFrame:CGRectMake(85, 400, 70, 70)];
        Cyan = [[UIImageView alloc] initWithFrame:CGRectMake(166, 400, 70, 70)];
        Silver = [[UIImageView alloc] initWithFrame:CGRectMake(249, 400, 70, 70)];
        
        MiddleButton = [[UIImageView alloc] initWithFrame:CGRectMake(87, 209, 150, 150)];
        Replay = [[UIButton alloc] initWithFrame:CGRectMake(87, 209, 150, 150)];
        
    } else if (screenHeight == 667) {
        Red = [[UIImageView alloc] initWithFrame:CGRectMake(1, 570, 84, 84)];
        Blue = [[UIImageView alloc] initWithFrame:CGRectMake(100, 570, 84, 84)];
        Green = [[UIImageView alloc] initWithFrame:CGRectMake(197, 570, 84, 84)];
        Yellow = [[UIImageView alloc] initWithFrame:CGRectMake(291, 570, 84, 84)];
        
        Orange = [[UIImageView alloc] initWithFrame:CGRectMake(1, 466, 84, 84)];
        Purple = [[UIImageView alloc] initWithFrame:CGRectMake(100, 466, 84, 84)];
        Cyan = [[UIImageView alloc] initWithFrame:CGRectMake(197, 466, 84, 84)];
        Silver = [[UIImageView alloc] initWithFrame:CGRectMake(291, 466, 84, 84)];
        
        MiddleButton = [[UIImageView alloc] initWithFrame:CGRectMake(97, 244, 180, 180)];
        Replay = [[UIButton alloc] initWithFrame:CGRectMake(97, 244, 180, 180)];
        
        inGameScore.center = CGPointMake(190, 70);
        inGameTimer.center = CGPointMake(27, 70);
        
        HighScore.center = CGPointMake(208, 134);
        FinalScore.center = CGPointMake(16, 134);
        
        One.center = CGPointMake(50, 112);
        Two.center = CGPointMake(240, 112);
        
    } else if (screenHeight == 736) {
        Red = [[UIImageView alloc] initWithFrame:CGRectMake(1, 625, 91, 91)];
        Blue = [[UIImageView alloc] initWithFrame:CGRectMake(107, 625, 91, 91)];
        Green = [[UIImageView alloc] initWithFrame:CGRectMake(217, 625, 91, 91)];
        Yellow = [[UIImageView alloc] initWithFrame:CGRectMake(323, 625, 91, 91)];
        
        Orange = [[UIImageView alloc] initWithFrame:CGRectMake(1, 514, 91, 91)];
        Purple = [[UIImageView alloc] initWithFrame:CGRectMake(107, 514, 91, 91)];
        Cyan = [[UIImageView alloc] initWithFrame:CGRectMake(217, 514, 91, 91)];
        Silver = [[UIImageView alloc] initWithFrame:CGRectMake(323, 514, 91, 91)];

        MiddleButton = [[UIImageView alloc] initWithFrame:CGRectMake(110, 270, 195, 195)];
        Replay = [[UIButton alloc] initWithFrame:CGRectMake(110, 270, 195, 195)];
        
        inGameScore.center = CGPointMake(190, 70);
        inGameTimer.center = CGPointMake(47, 70);
        
        HighScore.center = CGPointMake(247, 134);
        FinalScore.center = CGPointMake(16, 134);
        
        One.center = CGPointMake(50, 112);
        Two.center = CGPointMake(279, 112);
    }
    
    UIImage *img = [UIImage imageNamed:@"Play.png"];
    [Replay setImage:img forState:UIControlStateNormal];
    [Replay addTarget:self action:@selector(Replay:) forControlEvents:UIControlEventTouchUpInside];
    [Brightness addTarget:self action:@selector(Brightness:) forControlEvents:UIControlEventTouchUpInside];
    
    MiddleButton.image = [UIImage imageNamed:@"Red.png"];
    Yellow.image = [UIImage imageNamed:@"Yellow.png"];
    Green.image = [UIImage imageNamed:@"Green.png"];
    Blue.image = [UIImage imageNamed:@"Blue.png"];
    Red.image = [UIImage imageNamed:@"Red.png"];
    Cyan.image = [UIImage imageNamed:@"Cyan.png"];
    Purple.image = [UIImage imageNamed:@"Purple.png"];
    Silver.image = [UIImage imageNamed:@" Silver.png"];
    Orange.image = [UIImage imageNamed:@"Orange.png"];
    
    [self.view addSubview:Red];
    [self.view addSubview:Green];
    [self.view addSubview:Yellow];
    [self.view addSubview:Blue];
    [self.view addSubview:Orange];
    [self.view addSubview:Purple];
    [self.view addSubview:Cyan];
    [self.view addSubview:Silver];
    [self.view addSubview:Replay];
    [self.view addSubview:MiddleButton];
    [self authentication];
    HighScoreN = [[NSUserDefaults standardUserDefaults] integerForKey:@"NewHighScoreSaved"];
    Birght = [[NSUserDefaults standardUserDefaults] integerForKey:@"BrightnessSaved"];
    
    if (Birght == 0) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    } else if (Birght == 1) {
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    
    Red.alpha = 0;
    Blue.alpha =0;
    Green.alpha = 0;
    Yellow.alpha = 0;
    Orange.alpha = 0;
    Brightness.alpha = 0;
    Purple.alpha = 0;
    Silver.alpha = 0;
    Cyan.alpha = 0;
    [self performSelector:@selector(AnimateIn) withObject:nil afterDelay:0.6];
    
    inGameScore.alpha = 0;
    inGameTimer.alpha = 0;
    One.alpha = 0;
    Two.alpha = 0;
    HighScore.alpha = 0;
    FinalScore.alpha = 0;
    MiddleButton.alpha = 0;
    Replay.alpha = 1;
    
    pOne.x = Yellow.center.x;
    pOne.y = Yellow.center.y;
    
    pTwo.x = Blue.center.x;
    pTwo.y = Blue.center.y;
    
    pThree.x = Red.center.x;
    pThree.y = Red.center.y;
    
    pFour.x = Green.center.x;
    pFour.y = Green.center.y;
    
    pFive.x = Orange.center.x;
    pFive.y = Orange.center.y;
    
    pSix.x = Purple.center.x;
    pSix.y = Purple.center.y;
    
    pSeven.x = Cyan.center.x;
    pSeven.y = Cyan.center.y;
    
    pEight.x = Silver.center.x;
    pEight.y = Silver.center.y;
}

-(void)AnimateIn
{
    [Red setAlpha:0];
    [Green setAlpha:0];
    [Blue setAlpha:0];
    [Yellow setAlpha:0];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.f];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [Red setAlpha:1];
    [Green setAlpha:1];
    [Blue setAlpha:1];
    [Yellow setAlpha:1];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma MARK Game One

-(void)GameOneViewDidLoad
{
    Score = 0;
    Time = 5;
    
    Other = NO;
    
    inGameTimer.text = [NSString stringWithFormat:@"%.2f", Time];
    inGameScore.text = [NSString stringWithFormat:@"%i", Score];
    
    int number = arc4random()%5;
    
    switch (number) {
        case 1:
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
            break;
        case 2:
            MiddleButton.image = [UIImage imageNamed:@"Blue.png"];
            randomNumber = 2;
            break;
        case 3:
            MiddleButton.image = [UIImage imageNamed:@"Green.png"];
            randomNumber = 3;
            break;
        case 4:
            MiddleButton.image = [UIImage imageNamed:@"Yellow.png"];
            randomNumber = 4;
            break;
        default:
            break;
    }
    
    if (MiddleButton.image == [UIImage imageNamed:@"Orange.png"] && Score < 10) {
        MiddleButton.image = [UIImage imageNamed:@"Red.png"];
        randomNumber = 1;
    }
    
    if (MiddleButton.image == [UIImage imageNamed:@"Purple.png"] && Score < 20) {
        MiddleButton.image = [UIImage imageNamed:@"Red.png"];
        randomNumber = 1;
    }
    
    if (MiddleButton.image == [UIImage imageNamed:@"Cyan.png"] && Score < 30) {
        MiddleButton.image = [UIImage imageNamed:@"Red.png"];
        randomNumber = 1;
    }
    
    if (MiddleButton.image == [UIImage imageNamed:@" Silver.png"] && Score < 40) {
        MiddleButton.image = [UIImage imageNamed:@"Red.png"];
        randomNumber = 1;
    }
    
    if (MiddleButton.image == [UIImage imageNamed:@"Red.png"]) {
        randomNumber = 1;
    }
    
    UITapGestureRecognizer *RedTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Red:)];
    RedTap.numberOfTapsRequired = 1;
    Red.userInteractionEnabled = YES;
    [Red addGestureRecognizer:RedTap];
    
    UITapGestureRecognizer *BlueTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Blue:)];
    BlueTap.numberOfTapsRequired = 1;
    Blue.userInteractionEnabled = YES;
    [Blue addGestureRecognizer:BlueTap];
    
    UITapGestureRecognizer *GreenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Green:)];
    GreenTap.numberOfTapsRequired = 1;
    Green.userInteractionEnabled = YES;
    [Green addGestureRecognizer:GreenTap];
    
    UITapGestureRecognizer *YellowTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Yellow:)];
    YellowTap.numberOfTapsRequired = 1;
    Yellow.userInteractionEnabled = YES;
    [Yellow addGestureRecognizer:YellowTap];
    
    UITapGestureRecognizer *OrangeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Orange:)];
    OrangeTap.numberOfTapsRequired = 1;
    Orange.userInteractionEnabled = YES;
    [Orange addGestureRecognizer:OrangeTap];
    
    UITapGestureRecognizer *PurpleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Purple:)];
    PurpleTap.numberOfTapsRequired = 1;
    Purple.userInteractionEnabled = YES;
    [Purple addGestureRecognizer:PurpleTap];
    
    UITapGestureRecognizer *CyanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Cyan:)];
    CyanTap.numberOfTapsRequired = 1;
    Cyan.userInteractionEnabled = YES;
    [Cyan addGestureRecognizer:CyanTap];
    
    UITapGestureRecognizer *SilverTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Silver:)];
    SilverTap.numberOfTapsRequired = 1;
    Silver.userInteractionEnabled = YES;
    [Silver addGestureRecognizer:SilverTap];
}

-(void)ChangeButton
{
    if (GameOver == YES) {
        
    } else if (GameOver == NO) {
    
    [theTimer invalidate];
    theTimer = nil;
    CFRunLoopStop(CFRunLoopGetCurrent());
    inGameScore.text = [NSString stringWithFormat:@"%i", Score];
    
    int number;
    
    if (Score < 12) {
        number = arc4random()%4;
    } else if (Score > 12 && Score < 22) {
        number = arc4random()%5;
    } else if (Score > 22 && Score < 32) {
        number = arc4random()%6;
    } else if (Score > 32 && Score < 42) {
        number = arc4random()%7;
    } else if (Score > 42) {
        number = arc4random()%8;
    }
    
    Time = Time + 0.4;
    if (Time > 5) {
        Time = 5;
    }
    inGameTimer.text = [NSString stringWithFormat:@"%.2f", Time];
    
    switch (number) {
        case 0:
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
            break;
        case 1:
            MiddleButton.image = [UIImage imageNamed:@"Blue.png"];
            randomNumber = 2;
            break;
        case 2:
            MiddleButton.image = [UIImage imageNamed:@"Green.png"];
            randomNumber = 3;
            break;
        case 3:
            MiddleButton.image = [UIImage imageNamed:@"Yellow.png"];
            randomNumber = 4;
            break;
        case 4:
            MiddleButton.image = [UIImage imageNamed:@"Orange.png"];
            randomNumber = 5;
            break;
        case 5:
            MiddleButton.image = [UIImage imageNamed:@"Purple.png"];
            randomNumber = 6;
            break;
        case 6:
            MiddleButton.image = [UIImage imageNamed:@"Cyan.png"];
            randomNumber = 7;
            break;
        case 7:
            MiddleButton.image = [UIImage imageNamed:@" Silver.png"];
            randomNumber = 8;
            break;
        default:
            break;
    }
        
        if (MiddleButton.image == [UIImage imageNamed:@"Orange.png"] && Score < 10) {
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
        }
    
        if (MiddleButton.image == [UIImage imageNamed:@"Purple.png"] && Score < 20) {
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
        }
        
        if (MiddleButton.image == [UIImage imageNamed:@"Cyan.png"] && Score < 30) {
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
        }
        
        if (MiddleButton.image == [UIImage imageNamed:@" Silver.png"] && Score < 40) {
            MiddleButton.image = [UIImage imageNamed:@"Red.png"];
            randomNumber = 1;
        }
        
    theTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(Timer) userInfo:nil repeats:YES];
    }
}

-(void)Timer
{
    Time = Time - 0.001;
    NSLog(@"%.3f", Time);
    inGameTimer.text = [NSString stringWithFormat:@"%.2f", Time];
    if (Time <= 0) {
        GameOver = YES;
        [self EndGame];
        [theTimer invalidate];
        theTimer = nil;
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
}

-(void)EndGame
{
    Red.userInteractionEnabled = NO;
    Blue.userInteractionEnabled = NO;
    Green.userInteractionEnabled = NO;
    Yellow.userInteractionEnabled = NO;
    Orange.userInteractionEnabled = NO;
    Purple.userInteractionEnabled = NO;
    Cyan.userInteractionEnabled = NO;
    Silver.userInteractionEnabled = NO;
    
    [Faster invalidate];
    Faster = nil;
    [theTimer invalidate];
    theTimer = nil;
    CFRunLoopStop(CFRunLoopGetCurrent());
    [HighScore setAlpha:0];
    [FinalScore setAlpha:0];
    [One setAlpha:0];
    [Two setAlpha:0];
    [Replay setAlpha:0];
    [inGameTimer setAlpha:1];
    [Brightness setAlpha:0];
    [inGameScore setAlpha:1];
    [MiddleButton setAlpha:1];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [inGameScore setAlpha:0];
    [inGameTimer setAlpha:0];
    [MiddleButton setAlpha:0];
    [HighScore setAlpha:1];
    [Brightness setAlpha:1];
    [Replay setAlpha:1];
    [FinalScore setAlpha:1];
    [One setAlpha:1];
    [Two setAlpha:1];
    [UIView commitAnimations];
    if (Score > HighScoreN) {
        HighScoreN = Score;
        [[NSUserDefaults standardUserDefaults] setInteger:HighScoreN forKey:@"NewHighScoreSaved"];
    }
    [self reportScore];
    FinalScore.text = [NSString stringWithFormat:@"%i", Score];
    HighScore.text = [NSString stringWithFormat:@"%li", (long)HighScoreN];
}

-(IBAction)Brightness:(id)sender
{
    if (Birght == 1) {
        Birght = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:Birght forKey:@"BrightnessSaved"];
        [self.view setBackgroundColor:[UIColor blackColor]];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [UIView commitAnimations];
    } else if (Birght == 0) {
        Birght = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:Birght forKey:@"BrightnessSaved"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [self.view setBackgroundColor:[UIColor blackColor]];
        [UIView commitAnimations];
    }
}

-(IBAction)Replay:(id)sender
{
    
    if (Score > 10) {
        [Orange setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Orange setAlpha:0];
        [UIView commitAnimations];
    }
    
    if (Score > 20) {
        [Purple setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Purple setAlpha:0];
        [UIView commitAnimations];
    }
    
    if (Score > 30) {
        [Cyan setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Cyan setAlpha:0];
        [UIView commitAnimations];
    }
    
    if (Score > 40) {
        [Silver setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Silver setAlpha:0];
        [UIView commitAnimations];
    }
    
    if (Score > 60) {
        Yellow.center = CGPointMake(pOne.x, pOne.y);
        Green.center = CGPointMake(pFour.x, pFour.y);
        Blue.center = CGPointMake(pTwo.x, pTwo.y);
        Red.center = CGPointMake(pThree.x, pThree.y);
    }
    
    GameOver = NO;
    [Replay setAlpha:1];
    [One setAlpha:1];
    [FinalScore setAlpha:1];
    [HighScore setAlpha:1];
    [inGameTimer setAlpha:0];
    [inGameScore setAlpha:0];
    [Brightness setAlpha:1];
    [MiddleButton setAlpha:0];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [inGameScore setAlpha:1];
    [inGameTimer setAlpha:1];
    [Brightness setAlpha:0];
    [One setAlpha:0];
    [Two setAlpha:0];
    [MiddleButton setAlpha:1];
    [FinalScore setAlpha:0];
    [HighScore setAlpha:0];
    [Replay setAlpha:0];
    [UIView commitAnimations];
    [self GameOneViewDidLoad];
}

#pragma MARK The Buttons

-(void)Red:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 1) {
        [self EndGame];
    } else {
        [self RedButtonSound];
        [Red setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Red setAlpha:0];
        [UIView commitAnimations];
        
        [Red setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Red setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}


-(void)Blue:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 2) {
        [self EndGame];
    } else {
        [self BlueButtonSound];
        [Blue setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Blue setAlpha:0];
        [UIView commitAnimations];
        
        [Blue setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Blue setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Yellow:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 4) {
        [self EndGame];
    } else {
        [self YellowButtonSound];
        [Yellow setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Yellow setAlpha:0];
        [UIView commitAnimations];
        
        [Yellow setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Yellow setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Green:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 3) {
        [self EndGame];
    } else {
        [self GreenButtonSound];
        [Green setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Green setAlpha:0];
        [UIView commitAnimations];
        
        [Green setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Green setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Orange:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 5) {
        [self EndGame];
    } else {
        [self OrangeButtonSound];
        [Orange setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Orange setAlpha:0];
        [UIView commitAnimations];
        
        [Orange setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Orange setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Purple:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 6) {
        [self EndGame];
    } else {
        [self PurpleButtonSound];
        [Purple setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Purple setAlpha:0];
        [UIView commitAnimations];
        
        [Purple setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Purple setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Cyan:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 7) {
        [self EndGame];
    } else {
        [self CyanButtonSound];
        [Cyan setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Cyan setAlpha:0];
        [UIView commitAnimations];
        
        [Cyan setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Cyan setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

-(void)Silver:(UITapGestureRecognizer *)sender
{
    if (randomNumber != 8) {
        [self EndGame];
    } else {
        [self SilverButtonSound];
        [Silver setAlpha:1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [Silver setAlpha:0];
        [UIView commitAnimations];
        
        [Silver setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.05];
        [UIView setAnimationDuration:0.05];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Silver setAlpha:1];
        [UIView commitAnimations];
        Score = Score + 1;
        [self ChangeButton];
    }
}

#pragma Mark The Banner

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"ad banner action is about to start");
    return YES;
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad banner will load");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad banner did load ad");
    [UIView animateWithDuration:0.5 animations:^{
        self.Banner.alpha = 1.0;
    }];
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"Banner action did finish");
    self.Banner = nil;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Error; %@", [error localizedDescription]);
    [UIView animateWithDuration:0.5 animations:
     ^{ self.Banner.alpha = 0.0;
         self.Banner = nil;
     }];
}

#pragma Mark The Sound

-(void)RedButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundOne" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundOne = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundOne play];
    [self Check];
}

-(void)GreenButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundTwo" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundTwo = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundTwo play];
    [self Check];
}

-(void)YellowButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundThree" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundThree = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundThree play];
    [self Check];
}

-(void)BlueButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundFour" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundFour = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundFour play];
    [self Check];
}

-(void)OrangeButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundOne" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundOne = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundOne play];
    [self Check];
}

-(void)SilverButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundTwo" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundTwo = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundTwo play];
    [self Check];
}

-(void)CyanButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundThree" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundThree = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundThree play];
    [self Check];
}

-(void)PurpleButtonSound
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"LaSoundFour" ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    NSError *error;
    self.SoundFour = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    [self.SoundFour play];
    [self Check];
}

#pragma Mark Difficulty

-(void)Check
{
    if (Score == 10) {
        [Orange setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Orange setAlpha:1];
        [UIView commitAnimations];
        Orange.userInteractionEnabled = YES;
    }
    
    if (Score == 20) {
        [Purple setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Purple setAlpha:1];
        [UIView commitAnimations];
        Purple.userInteractionEnabled = YES;
    }
    
    if (Score == 30) {
        [Cyan setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Cyan setAlpha:1];
        [UIView commitAnimations];
        Cyan.userInteractionEnabled = YES;
    }
    
    if (Score == 40) {
        [Silver setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [Silver setAlpha:1];
        [UIView commitAnimations];
        Silver.userInteractionEnabled = YES;
    }
    
    if (Score == 60 || Score == 65 || Score == 70 || Score == 75 || Score == 80 || Score == 85 || Score == 90 || Score == 95) {
        [self Rotation];
    }
    
    if (Score > 100) {
        [self Rotation];
    }
}

-(void)TimerSwitcher
{
    int RandomPosition = arc4random()%8;
    if (RandomPosition == harder) {
        do {
        RandomPosition = arc4random()%8;
        } while (RandomPosition != harder);
    }
    harder = RandomPosition;
    
    switch (RandomPosition) {
        case 1:
            Red.center = CGPointMake(pOne.x, pOne.y);
            Blue.center = CGPointMake(pTwo.x, pTwo.y);
            Yellow.center = CGPointMake(pThree.x, pThree.y);
            Green.center = CGPointMake(pFour.x, pFour.y);
            Orange.center = CGPointMake(pFive.x, pFive.y);
            Purple.center = CGPointMake(pSix.x, pSix.y);
            Cyan.center = CGPointMake(pSeven.x, pSeven.y);
            Silver.center = CGPointMake(pEight.x, pEight.y);
            break;
        case 2:
            Red.center = CGPointMake(pTwo.x, pTwo.y);
            Blue.center = CGPointMake(pThree.x, pThree.y);
            Yellow.center = CGPointMake(pFour.x, pFour.y);
            Green.center = CGPointMake(pFive.x, pFive.y);
            Orange.center = CGPointMake(pSix.x, pSix.y);
            Purple.center = CGPointMake(pSeven.x, pSeven.y);
            Cyan.center = CGPointMake(pEight.x, pEight.y);
            Silver.center = CGPointMake(pOne.x, pOne.y);
            break;
        case 3:
            Red.center = CGPointMake(pThree.x, pThree.y);
            Blue.center = CGPointMake(pFour.x, pFour.y);
            Yellow.center = CGPointMake(pFive.x, pFive.y);
            Green.center = CGPointMake(pSix.x, pSix.y);
            Orange.center = CGPointMake(pSeven.x, pSeven.y);
            Purple.center = CGPointMake(pEight.x, pEight.y);
            Cyan.center = CGPointMake(pOne.x, pOne.y);
            Silver.center = CGPointMake(pTwo.x, pTwo.y);
            break;
        case 4:
            Red.center = CGPointMake(pFour.x, pFour.y);
            Blue.center = CGPointMake(pFive.x, pFive.y);
            Yellow.center = CGPointMake(pSix.x, pSix.y);
            Green.center = CGPointMake(pSeven.x, pSeven.y);
            Orange.center = CGPointMake(pEight.x, pEight.y);
            Purple.center = CGPointMake(pOne.x, pOne.y);
            Cyan.center = CGPointMake(pTwo.x, pTwo.y);
            Silver.center = CGPointMake(pThree.x, pThree.y);
            break;
        case 5:
            Red.center = CGPointMake(pFive.x, pFive.y);
            Blue.center = CGPointMake(pSix.x, pSix.y);
            Yellow.center = CGPointMake(pSeven.x, pSeven.y);
            Green.center = CGPointMake(pEight.x, pEight.y);
            Orange.center = CGPointMake(pOne.x, pOne.y);
            Purple.center = CGPointMake(pTwo.x, pTwo.y);
            Cyan.center = CGPointMake(pThree.x, pThree.y);
            Silver.center = CGPointMake(pFour.x, pFour.y);
            break;
        case 6:
            Red.center = CGPointMake(pSix.x, pSix.y);
            Blue.center = CGPointMake(pSeven.x, pSeven.y);
            Yellow.center = CGPointMake(pEight.x, pEight.y);
            Green.center = CGPointMake(pOne.x, pOne.y);
            Orange.center = CGPointMake(pTwo.x, pTwo.y);
            Purple.center = CGPointMake(pThree.x, pThree.y);
            Cyan.center = CGPointMake(pFour.x, pFour.y);
            Silver.center = CGPointMake(pFive.x, pFive.y);
            break;
        case 7:
            Red.center = CGPointMake(pSeven.x, pSeven.y);
            Blue.center = CGPointMake(pEight.x, pEight.y);
            Yellow.center = CGPointMake(pOne.x, pOne.y);
            Green.center = CGPointMake(pTwo.x, pTwo.y);
            Orange.center = CGPointMake(pThree.x, pThree.y);
            Purple.center = CGPointMake(pFour.x, pFour.y);
            Cyan.center = CGPointMake(pFive.x, pFive.y);
            Silver.center = CGPointMake(pSix.x, pSix.y);
            break;
        case 8:
            Red.center = CGPointMake(pEight.x, pEight.y);
            Blue.center = CGPointMake(pOne.x, pOne.y);
            Yellow.center = CGPointMake(pTwo.x, pTwo.y);
            Green.center = CGPointMake(pThree.x, pThree.y);
            Orange.center = CGPointMake(pFour.x, pFour.y);
            Purple.center = CGPointMake(pFive.x, pFive.y);
            Cyan.center = CGPointMake(pSix.x, pSix.y);
            Silver.center = CGPointMake(pSeven.x, pSeven.y);
            break;
        default:
            break;
    }
}

-(void)Rotation
{
    int RandomPosition = arc4random()%8;
    
    switch (RandomPosition) {
        case 1:
            Red.center = CGPointMake(pOne.x, pOne.y);
            Blue.center = CGPointMake(pTwo.x, pTwo.y);
            Yellow.center = CGPointMake(pThree.x, pThree.y);
            Green.center = CGPointMake(pFour.x, pFour.y);
            Orange.center = CGPointMake(pFive.x, pFive.y);
            Purple.center = CGPointMake(pSix.x, pSix.y);
            Cyan.center = CGPointMake(pSeven.x, pSeven.y);
            Silver.center = CGPointMake(pEight.x, pEight.y);
            break;
        case 2:
            Red.center = CGPointMake(pTwo.x, pTwo.y);
            Blue.center = CGPointMake(pThree.x, pThree.y);
            Yellow.center = CGPointMake(pFour.x, pFour.y);
            Green.center = CGPointMake(pFive.x, pFive.y);
            Orange.center = CGPointMake(pSix.x, pSix.y);
            Purple.center = CGPointMake(pSeven.x, pSeven.y);
            Cyan.center = CGPointMake(pEight.x, pEight.y);
            Silver.center = CGPointMake(pOne.x, pOne.y);
            break;
        case 3:
            Red.center = CGPointMake(pThree.x, pThree.y);
            Blue.center = CGPointMake(pFour.x, pFour.y);
            Yellow.center = CGPointMake(pFive.x, pFive.y);
            Green.center = CGPointMake(pSix.x, pSix.y);
            Orange.center = CGPointMake(pSeven.x, pSeven.y);
            Purple.center = CGPointMake(pEight.x, pEight.y);
            Cyan.center = CGPointMake(pOne.x, pOne.y);
            Silver.center = CGPointMake(pTwo.x, pTwo.y);
            break;
        case 4:
            Red.center = CGPointMake(pFour.x, pFour.y);
            Blue.center = CGPointMake(pFive.x, pFive.y);
            Yellow.center = CGPointMake(pSix.x, pSix.y);
            Green.center = CGPointMake(pSeven.x, pSeven.y);
            Orange.center = CGPointMake(pEight.x, pEight.y);
            Purple.center = CGPointMake(pOne.x, pOne.y);
            Cyan.center = CGPointMake(pTwo.x, pTwo.y);
            Silver.center = CGPointMake(pThree.x, pThree.y);
            break;
        case 5:
            Red.center = CGPointMake(pFive.x, pFive.y);
            Blue.center = CGPointMake(pSix.x, pSix.y);
            Yellow.center = CGPointMake(pSeven.x, pSeven.y);
            Green.center = CGPointMake(pEight.x, pEight.y);
            Orange.center = CGPointMake(pOne.x, pOne.y);
            Purple.center = CGPointMake(pTwo.x, pTwo.y);
            Cyan.center = CGPointMake(pThree.x, pThree.y);
            Silver.center = CGPointMake(pFour.x, pFour.y);
            break;
        case 6:
            Red.center = CGPointMake(pSix.x, pSix.y);
            Blue.center = CGPointMake(pSeven.x, pSeven.y);
            Yellow.center = CGPointMake(pEight.x, pEight.y);
            Green.center = CGPointMake(pOne.x, pOne.y);
            Orange.center = CGPointMake(pTwo.x, pTwo.y);
            Purple.center = CGPointMake(pThree.x, pThree.y);
            Cyan.center = CGPointMake(pFour.x, pFour.y);
            Silver.center = CGPointMake(pFive.x, pFive.y);
            break;
        case 7:
            Red.center = CGPointMake(pSeven.x, pSeven.y);
            Blue.center = CGPointMake(pEight.x, pEight.y);
            Yellow.center = CGPointMake(pOne.x, pOne.y);
            Green.center = CGPointMake(pTwo.x, pTwo.y);
            Orange.center = CGPointMake(pThree.x, pThree.y);
            Purple.center = CGPointMake(pFour.x, pFour.y);
            Cyan.center = CGPointMake(pFive.x, pFive.y);
            Silver.center = CGPointMake(pSix.x, pSix.y);
            break;
        case 8:
            Red.center = CGPointMake(pEight.x, pEight.y);
            Blue.center = CGPointMake(pOne.x, pOne.y);
            Yellow.center = CGPointMake(pTwo.x, pTwo.y);
            Green.center = CGPointMake(pThree.x, pThree.y);
            Orange.center = CGPointMake(pFour.x, pFour.y);
            Purple.center = CGPointMake(pFive.x, pFive.y);
            Cyan.center = CGPointMake(pSix.x, pSix.y);
            Silver.center = CGPointMake(pSeven.x, pSeven.y);
            break;
        default:
            break;
    }
}

@end
