//
//  MainViewController.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"

@interface MainViewController : UIViewController
//Outlets
@property (weak, nonatomic) IBOutlet UIImageView *UIV1;
@property (weak, nonatomic) IBOutlet UIImageView *UIV2;
//Properties
@property(nonatomic,strong) NSMutableArray *Example1;
@property(nonatomic,strong) NSMutableArray *Example2;
@property(nonatomic,strong) NSMutableString* Buffer;
@property(nonatomic,strong) UIImage *UI1, *UI2, *UI3;

- (IBAction)UIVB1:(id)sender;
- (IBAction)UIVB2:(id)sender;

@end
