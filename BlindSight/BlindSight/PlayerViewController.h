//
//  PlayerViewController.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
//My Classes
#import "BSImage.h"
#import "BSSettings.h"
//Filters Classes
#import "GPUImageGrayscaleFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"
//ViewControllers
#import "SettingsViewController.h"


@interface PlayerViewController : UIViewController

//Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoadingProcess;

//Properties
@property UIImage *image1;
@property UIImage *image2;
@property UIImage *image3;
@property BSSettings *Settings;

//Methods
- (IBAction)StartSpinning;
- (IBAction)Analyze:(id)sender;
- (IBAction)ReturnToPreviousView:(id)sender;


@end
