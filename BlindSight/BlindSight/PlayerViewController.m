//
//  PlayerViewController.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController
//Outlets
@synthesize LoadingProcess;
@synthesize imageView;
//Properties
@synthesize image1;
@synthesize image2;
@synthesize image3;
@synthesize Settings;

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
    self.LoadingProcess.hidesWhenStopped = YES ;
    Settings = [[BSSettings alloc]init];
    SettingsViewController *SVC = [[SettingsViewController alloc]init];
    Settings = [SVC loadData];
    [imageView setImage:image1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StartSpinning
{
    [self.LoadingProcess startAnimating];
}

- (IBAction)Analyze:(id)sender
{
    
    [self performSelectorInBackground:@selector(StartSpinning) withObject:nil];
    /*
    self.image1 = [UIImage imageNamed:@"1a.jpg"];
    self.image2 = [UIImage imageNamed:@"2a.jpg"];
    self.image3 = [UIImage imageNamed:@"3a.jpg"];
    */
    BSImage *BSI = [[BSImage alloc] initWithImage : self.image1];
    
    UInt8 *pixelDifference = [BSI ImageToArray : self.image1 withSettings:Settings];
    UInt8 *pixelDifference2 = [BSI ImageToArray : self.image2 withSettings:Settings];
    UInt8 *pixelDifference3 = [BSI ImageToArray : self.image3 withSettings:Settings];
    
    UInt8 *pixelMax = [BSI CompareA: pixelDifference B : pixelDifference2 C : pixelDifference3 withSettings:Settings];
    
    if(Settings.ErrorCorrection)
        pixelMax =  [BSI ErrorCorrectImage: self.image1 WithTable : pixelMax withSettings:Settings];
    
    UIImage *newImage = [BSI SaveImage : pixelMax];
    
    [self.imageView setImage:newImage];
    [self.LoadingProcess stopAnimating];
    
}

- (IBAction)ReturnToPreviousView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"SettingsSegue"] )
    {
        SettingsViewController *SVC = [segue destinationViewController];
        SVC.SVCSettings = Settings;
    }
    
}

@end
