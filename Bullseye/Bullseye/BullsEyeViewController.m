//
//  BullsEyeViewController.m
//  Bullseye
//
//  Created by Randy Ram on 1/21/14.
//  Copyright (c) 2014 Randy Ram. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController
{
    int _currentValue;
    int _targetValue;
    int _score;
    int _round;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self startNewGame];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed: @"SliderTrackLeft"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,14,0,14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,14,0,14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
}

- (void) startNewRound
{
    _round += 1;
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
}

- (void) updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",_targetValue];
    self.scoreLabel.text =  [NSString stringWithFormat:@"%d",_score];
    self.roundLabel.text = [NSString stringWithFormat: @"%d", _round];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction) showAlert
{
    int difference = abs(_currentValue - _targetValue);
    int points = 100 - difference;
    
    NSString *title;
    if (difference == 0)
    {
        title = @"Perfect!";
        points += 100;
    }
    else if(difference < 5)
    {
        title = @"You almost had it!";
        if(difference == 1)
        {
            points += 50;
        }
    }
    else
    {
        title = @"Not even close...";
    }
    
    _score += points;
    
    
    NSString *message = [NSString stringWithFormat: @"Target Value:%d\nYou chose: %d\nYou scored %d points",_targetValue,_currentValue,points];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message: message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}


- (IBAction) sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
    //NSLog(@"The value of the slider is now: %f", slider.value);
}

-(IBAction) startOver
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

-(void) startNewGame
{
    _score = 0;
    _round = 0;
    [self startNewRound];
    [self updateLabels];
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
