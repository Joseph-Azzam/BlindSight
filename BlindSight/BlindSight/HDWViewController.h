//
//  HDWViewController.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
//My Classes
#import "BSImage.h"
#import "BSSettings.h"
//Filters Classes
#import "GPUImageGrayscaleFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"

@interface HDWViewController : UIViewController

//Outlets
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoadingProcess;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//Properties
@property UIImage *image1;
@property UIImage *image2;
@property UIImage *image3;
@property BSSettings *Settings;

//Methods
- (IBAction)OriginalButton:(id)sender;
- (IBAction)TopViewButton:(id)sender;
- (IBAction)GrayscaleButton:(id)sender;
- (IBAction)DifferenceButton:(id)sender;
- (IBAction)PrewittButton:(id)sender;
- (IBAction)ErrorCorrectionButton:(id)sender;

- (IBAction)ReturnToPreviousView:(id)sender;
- (IBAction)StartSpinning;

@end
