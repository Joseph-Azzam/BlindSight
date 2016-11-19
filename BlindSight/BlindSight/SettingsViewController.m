//
//  SettingsViewController.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize SVCSettings;

@synthesize HS;
@synthesize VS;
@synthesize ST;
@synthesize SP;
@synthesize EC;
@synthesize ECT;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self TransferFromSettings];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ReturnToPreviousView:(id)sender
{
    PlayerViewController *PVC = (PlayerViewController*)[self backViewController ];
    [self TransferToSettings];
    PVC.Settings = SVCSettings;
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) TransferToSettings
{
    SVCSettings.HorizontalScanning = HS.on;
    SVCSettings.VerticalScanning = VS.on;
    SVCSettings.ScanThreshold = ST.value;
    SVCSettings.SafePixels = SP.on;
    SVCSettings.ErrorCorrection = EC.on;
    SVCSettings.ErrorCorrectionThreshold = ECT.value;
}

- (void) TransferFromSettings
{
    HS.on = SVCSettings.HorizontalScanning;
    VS.on = SVCSettings.VerticalScanning;
    ST.value = SVCSettings.ScanThreshold;
    SP.on = SVCSettings.SafePixels;
    EC.on = SVCSettings.ErrorCorrection;
    ECT.value = SVCSettings.ErrorCorrectionThreshold;
}

- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];

}

- (IBAction)ResetButton:(id)sender
{
    SVCSettings = [[BSSettings alloc]init];
    [self TransferFromSettings];
}

-(NSString *) getFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    return [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"BSSettings.plist"];
}

-(void) saveData
{
    [NSKeyedArchiver archiveRootObject:SVCSettings toFile:[self getFilePath]];
    
}

-(BSSettings *) loadData
{
    BSSettings *Settings = [[BSSettings alloc]init];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]];
    if(fileExists)
    Settings = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    return Settings;
}

- (IBAction)SaveButton:(id)sender
{
    [self saveData];
    [self getFilePath];
}


@end
