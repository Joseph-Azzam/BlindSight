//
//  BSFunctions.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>
//My Classes
#import "BSSettings.h"
//Filters Classes
#import "GPUImageGrayscaleFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"


@interface BSImage : NSObject

@property int width;//image width
@property int height;//image height
@property int dataLength;
@property int BytesPerRow;
@property CGColorSpaceRef ColorSpace;


-(id)initWithImage:(UIImage *)image;
-(UInt8*)ImageToArray:(UIImage *)image withSettings:(BSSettings*)Settings;//Analyse image
-(UInt8*)CompareA:(UInt8*) pixelDifference B : (UInt8*) pixelDifference2 C : (UInt8*) pixelDifference3 withSettings:(BSSettings*)Settings;//find max difference of the 3 images
-(UInt8*)ErrorCorrectImage:(UIImage *) image WithTable : (UInt8*) pixelMax withSettings:(BSSettings*)Settings;
-(UIImage*)SaveImage : (UInt8*) pixelMax ;
@end
