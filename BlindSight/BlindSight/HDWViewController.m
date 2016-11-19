//
//  HDWViewController.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "HDWViewController.h"

@interface HDWViewController ()

@end

@implementation HDWViewController

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
	// Do any additional setup after loading the view.
    self.image1 = [UIImage imageNamed:@"1a.jpg"];
    self.image2 = [UIImage imageNamed:@"2a.jpg"];
    self.image3 = [UIImage imageNamed:@"3a.jpg"];
    Settings = [[BSSettings alloc]init];
    self.LoadingProcess.hidesWhenStopped = YES ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OriginalButton:(id)sender
{
    [self.imageView setImage:image1];
}

- (IBAction)TopViewButton:(id)sender
{
    [self.imageView setImage:[UIImage imageNamed:@"Top.jpg"]];
}

- (IBAction)GrayscaleButton:(id)sender
{
    GPUImageGrayscaleFilter *grayscalefilter = [[GPUImageGrayscaleFilter alloc] init];
    UIImage *FilteredImage = [grayscalefilter imageByFilteringImage:image1];
    [self.imageView setImage:FilteredImage];
}

- (IBAction)DifferenceButton:(id)sender
{
    [self performSelectorInBackground:@selector(StartSpinning) withObject:nil];
    
    Settings.ErrorCorrection = YES;
    
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

- (IBAction)PrewittButton:(id)sender
{
    GPUImagePrewittEdgeDetectionFilter *grayscalefilter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
    UIImage *FilteredImage = [grayscalefilter imageByFilteringImage:image1];
    [self.imageView setImage:FilteredImage];
}

- (IBAction)ErrorCorrectionButton:(id)sender
{
    [self performSelectorInBackground:@selector(StartSpinning) withObject:nil];
    
    Settings.ErrorCorrection = YES;
    
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

- (IBAction)StartSpinning
{
    [self.LoadingProcess startAnimating];
}

- (IBAction)ReturnToPreviousView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
