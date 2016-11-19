//
//  ExplanationViewController.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-01.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSSettings.h"
@interface ExplanationViewController : UIViewController
{
    IBOutlet UIImageView *imageView;
    IBOutlet UISwitch *ErrorCorrection;
    IBOutlet UISlider *ERIntensity;
    
}
@property UIImage *image1;
@property UIImage *image2;
@property UIImage *image3;
@property UIImage *filterimage;
@property BSSettings *Settings;


- (IBAction)Grayscale:(id)sender;
- (IBAction)Original:(id)sender;
- (IBAction)GrayscaleButton:(id)sender;
- (IBAction)PrewittButton:(id)sender;

@end
