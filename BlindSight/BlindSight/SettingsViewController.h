//
//  SettingsViewController.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"
//My Classes
#import "BSSettings.h"

@interface SettingsViewController : UIViewController

@property (nonatomic,strong) BSSettings *SVCSettings;
//Outlets
@property (weak, nonatomic) IBOutlet UISwitch *HS;
@property (weak, nonatomic) IBOutlet UISwitch *VS;
@property (weak, nonatomic) IBOutlet UISlider *ST;
@property (weak, nonatomic) IBOutlet UISwitch *SP;
@property (weak, nonatomic) IBOutlet UISwitch *EC;
@property (weak, nonatomic) IBOutlet UISlider *ECT;
//Methods

- (IBAction)ReturnToPreviousView:(id)sender;
- (UIViewController *)backViewController;
- (IBAction)ResetButton:(id)sender;
- (void) TransferToSettings;
- (void) TransferFromSettings;

//Saving the Settings for Next Use
-(NSString *) getFilePath;
-(void) saveData;
-(BSSettings *) loadData;
- (IBAction)SaveButton:(id)sender;


@end
