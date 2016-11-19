//
//  ExplanationViewController.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-01.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "ExplanationViewController.h"
#import "GPUImageGrayscaleFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"
#import "BSImage.h"

@interface ExplanationViewController ()

@end


@implementation ExplanationViewController
@synthesize image1;
@synthesize image2;
@synthesize image3;
@synthesize filterimage;

@synthesize Settings;

//-(BOOL)shou
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Settings = [Settings init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Grayscale:(id)sender {
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    GPUImageGrayscaleFilter *grayscalefilter = [[GPUImageGrayscaleFilter alloc] init];
    UIImage *FilteredImage = [grayscalefilter imageByFilteringImage:image];
    [imageView setImage:FilteredImage];
}

- (IBAction)Original:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    [imageView setImage: image];
}


- (IBAction)PrewittButton:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    GPUImagePrewittEdgeDetectionFilter *prewittfilter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
    UIImage *FilteredImage = [prewittfilter imageByFilteringImage:image];
    [imageView setImage:FilteredImage];
}


- (IBAction)GrayscaleButton:(id)sender
{
    self.image1 = [UIImage imageNamed:@"2.jpg"];
    self.image2 = [UIImage imageNamed:@"7.jpg"];
    self.image3 = [UIImage imageNamed:@"10.jpg"];
    
    BSImage *BSI = [[BSImage alloc] initWithImage : self.image1];
    
    UInt8 *pixelDifference = [BSI ImageToArray : self.image1 withSettings:Settings];
    UInt8 *pixelDifference2 = [BSI ImageToArray : self.image2 withSettings:Settings];
    UInt8 *pixelDifference3 = [BSI ImageToArray : self.image3 withSettings:Settings];
    
    UInt8 *pixelMax = [BSI CompareA: pixelDifference B : pixelDifference2 C : pixelDifference3 withSettings:Settings];
    
    if(ErrorCorrection.on)
        pixelMax =  [BSI ErrorCorrectImage: self.image1 WithTable : pixelMax withSettings:Settings];
    
    UIImage *newImage = [BSI SaveImage : pixelMax];
    
    [imageView setImage:newImage];
    
    
}

@end

