//
//  BSFunctions.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "BSImage.h"

float ** create(int r, int c){
    float **tmp=(float**)malloc(r*sizeof(float*));
    for(int i=0;i<r;++i)
        tmp[i]=(float*)malloc(c*sizeof(float));
    return tmp;
}

void destroy(float **tmp, int r){
    for(int i=0;i<r;++i)
        free(tmp[i]);
    free(tmp);
}


@implementation BSImage

@synthesize width;
@synthesize height;
@synthesize dataLength;
@synthesize BytesPerRow;
@synthesize ColorSpace;

-(id)initWithImage:(UIImage *)image{
    self=[super init];
    if (self){
        
        CGSize size= image.size;
        self.width = (int) size.width;
        self.height = (int) size.height;
        CGImageRef imageRef = [image CGImage];
        self.BytesPerRow = CGImageGetBytesPerRow(imageRef);
        self.ColorSpace = CGImageGetColorSpace(imageRef);

    }
    return self;
}



- (UInt8*)ImageToArray:(UIImage *)image withSettings:(BSSettings*)Settings
{

//turn image to grayscale
    GPUImageGrayscaleFilter *grayscalefilter = [[GPUImageGrayscaleFilter alloc] init];
    UIImage *FilteredImage = [grayscalefilter imageByFilteringImage:image];
    
    

//store pixels channels value in array
    CGImageRef imageRef = [FilteredImage CGImage];
    
	CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    
	UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(rawData);
 	UInt8 *pixelDifference = (UInt8 *) CFDataGetBytePtr(rawData);
    
	dataLength = CFDataGetLength(rawData);
    
     //Calculate the difference between the pixels
	for (int index = width*4; index < dataLength-(width*4); index += 4)
    {
        if( Settings.SafePixels == YES)
        {
            //skip first pixel
            if( (index-1) % width*4 == 0 )
            {
                pixelDifference[index-width*4]=0;
                pixelDifference[index-width*4+1]=0;
                pixelDifference[index-width*4+2]=0;
                index +=4 ;
            }
        }
        
        if( Settings.SafePixels == YES)
        {
            //skip last pixel
            if( (index+1) % width*4 == 0 )
            {
                pixelDifference[index-width*4]=0;
                pixelDifference[index-width*4+1]=0;
                pixelDifference[index-width*4+2]=0;
                index +=4 ;
            }
        }
        
        int tmp = pixelData[index];
        int h = (Settings.HorizontalScanning ? 1 : 0);
        int v = (Settings.VerticalScanning ? 1 : 0);
        pixelDifference[index-width*4]= h*abs(pixelData[index + 4]-tmp) + v*abs(pixelData[index + width*4]-tmp);
        
        if(pixelDifference[index-width*4] <= Settings.ScanThreshold)
            pixelDifference[index-width*4]=0;
        
        pixelDifference[index-width*4+1]=pixelDifference[index-width*4];
        pixelDifference[index-width*4+2]=pixelDifference[index-width*4];
        
        
        
    }
    
    return(pixelDifference);
}

-(UInt8*)CompareA:(UInt8*) pixelDifference B : (UInt8*) pixelDifference2 C : (UInt8*) pixelDifference3 withSettings:(BSSettings*)Settings
{

UInt8 *pixelMax = pixelDifference ;


for (int index = width*4; index < dataLength-(width*4); index += 4)
{
    
    if( Settings.SafePixels == YES)
    {
        //skip first pixel
        if( (index-1) % width*4 == 0 )
        {
            pixelMax[index-width*4]=0;
            pixelMax[index-width*4+1]=0;
            pixelMax[index-width*4+2]=0;
            index +=4 ;
        }
    }
    
    if( Settings.SafePixels == YES)
    {
        //skip last pixel
        if( (index+1) % width*4 == 0 )
        {
            pixelMax[index-width*4]=0;
            pixelMax[index-width*4+1]=0;
            pixelMax[index-width*4+2]=0;
            index +=4 ;
        }
    }
    
    if( abs(pixelDifference2[index-width*4] - pixelDifference[index-width*4]) <= Settings.zero && abs(pixelDifference2[index-width*4] - pixelDifference3[index-width*4] ) <= Settings.zero )
    {
        pixelMax[index-width*4]=pixelMax[index-2*width*4];
        pixelMax[index-width*4+1]=pixelMax[index-2*width*4+1];
        pixelMax[index-width*4+2]=pixelMax[index-2*width*4+2];
    }
    else
        if( ( pixelDifference[index-width*4] > pixelDifference2[index-width*4] && pixelDifference[index-width*4] > pixelDifference3[index-width*4] ) || ( pixelDifference[index-width*4] >= pixelDifference2[index-width*4] && pixelDifference[index-width*4] > pixelDifference3[index-width*4] ) || ( pixelDifference[index-width*4] > pixelDifference2[index-width*4] && pixelDifference[index-width*4] >= pixelDifference3[index-width*4] ) )
        {
            pixelMax[index-width*4]=255;
            pixelMax[index-width*4+1]=0;
            pixelMax[index-width*4+2]=0;
        }
        else
            if( ( pixelDifference2[index-width*4] > pixelDifference[index-width*4] && pixelDifference2[index-width*4] > pixelDifference3[index-width*4] ) || ( pixelDifference2[index-width*4] >= pixelDifference[index-width*4] && pixelDifference2[index-width*4] > pixelDifference3[index-width*4] ) || ( pixelDifference2[index-width*4] > pixelDifference[index-width*4] && pixelDifference2[index-width*4] >= pixelDifference3[index-width*4] ) )
            {
                pixelMax[index-width*4]=0;
                pixelMax[index-width*4+1]=255;
                pixelMax[index-width*4+2]=0;
            }
            else
            {
                pixelMax[index-width*4]=0;
                pixelMax[index-width*4+1]=0;
                pixelMax[index-width*4+2]=255;
            }
    
    
    
    
    //error correction
    if(pixelMax[index-width*4] != 0 && pixelMax[index-width*4] != 255)
        pixelMax[index-width*4]=0;
    
    if(pixelMax[index-width*4+1] != 0 && pixelMax[index-width*4+1] != 255)
        pixelMax[index-width*4+1]=0;
    
    if(pixelMax[index-width*4+2] != 0 && pixelMax[index-width*4+2] != 255)
        pixelMax[index-width*4+2]=255;
    
    if( pixelMax[index-width*4] == 0 && pixelMax[index-width*4+1] == 0 && pixelMax[index-width*4+2] == 0)
        pixelMax[index-width*4+2]=255;
    
}
    return(pixelMax);
}

-(UInt8*)ErrorCorrectImage:(UIImage *) image WithTable : (UInt8*) pixelMax withSettings:(BSSettings*)Settings
{
    image = [UIImage imageNamed:@"2.jpg"];
    GPUImagePrewittEdgeDetectionFilter *prewittfilter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
        UIImage *FilteredImage = [prewittfilter imageByFilteringImage:image];
    
    
    CGImageRef imageRef = [FilteredImage CGImage];
    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    
    UInt8 *edgeData = (UInt8 *) CFDataGetBytePtr(rawData);
    
    int r=0;
    int g=0;
    int b=0;
    //horizontal error correction
    for (int index = width*4; index < dataLength-(width*4); index += 4)
    {
        
        if( Settings.SafePixels == YES)
        {
            //skip first pixel
            if( (index-1) % width*4 == 0 )
            {
                pixelMax[index-width*4]=0;
                pixelMax[index-width*4+1]=0;
                pixelMax[index-width*4+2]=0;
                index +=4 ;
            }
        }
        
        
        if( Settings.SafePixels == YES)
        {
            //skip last pixel
            if( (index+1) % width*4 == 0 )
            {
                pixelMax[index-width*4]=0;
                pixelMax[index-width*4+1]=0;
                pixelMax[index-width*4+2]=0;
                index +=4 ;
            }
        }
        
        //////
        
        if( pixelMax[index - width*4] == 255 )
            r++;
        if( pixelMax[index - width*4+1] == 255 )
            g++;
        if( pixelMax[index - width*4+2] == 255 )
            b++;
        
        if( edgeData[index - width*4] >=  Settings.ErrorCorrectionThreshold || (index-width*4) % width*4 ==0 )
        {
            
            if ( r > g && r > b)
                for(int i=index - width*4 - r*4 ; i< index - width*4 ; i+=4 )
                {
                    pixelMax[i] = 255;
                    pixelMax[i+1] = 0;
                    pixelMax[i+2] = 0;
                }
            else
                if ( g > r && g > b)
                    for(int i=index - width*4 - 4*g ; i< index - width*4 ; i+=4 )
                    {
                        pixelMax[i] = 0;
                        pixelMax[i+1] = 255;
                        pixelMax[i+2] = 0;
                    }
                else
                    if ( b > r && b > g)
                        for(int i=index - width*4 - 4*b ; i< index - width*4 ; i+=4 )
                        {
                            pixelMax[i] = 0;
                            pixelMax[i+1] = 0;
                            pixelMax[i+2] = 255;
                        }
            r=0;
            g=0;
            b=0;
            
        }
    }
    //vertical error correction
    
    r=0;
    g=0;
    b=0;
    for(int j=0 ; j<height ; j++)
        for (int index = width*4+4*j; index < dataLength-(width*4); index +=width*4)
        {
            
            if( Settings.SafePixels == YES)
            {
                //skip first pixel
                if( (index-1) % width*4 == 0 )
                {
                    pixelMax[index-width*4]=0;
                    pixelMax[index-width*4+1]=0;
                    pixelMax[index-width*4+2]=0;
                    index +=4 ;
                }
            }
            
            
            if( Settings.SafePixels == YES)
            {
                //skip last pixel
                if( (index+1) % width*4 == 0 )
                {
                    pixelMax[index-width*4]=0;
                    pixelMax[index-width*4+1]=0;
                    pixelMax[index-width*4+2]=0;
                    index +=4 ;
                }
            }
            
            //////
            
            if( pixelMax[index - width*4] == 255 )
                r++;
            if( pixelMax[index - width*4+1] == 255 )
                g++;
            if( pixelMax[index - width*4+2] == 255 )
                b++;
            
            if( edgeData[index - width*4] >=  Settings.ErrorCorrectionThreshold || (index-width*4) % height ==0 )
            {
                
                if ( r > g && r > b)
                    for(int i=index - width*4 - r*4 ; i< index - width*4 ; i+=height )
                    {
                        pixelMax[i] = 255;
                        pixelMax[i+1] = 0;
                        pixelMax[i+2] = 0;
                    }
                else
                    if ( g > r && g > b)
                        for(int i=index - width*4 - 4*g ; i< index - width*4 ; i+=height )
                        {
                            pixelMax[i] = 0;
                            pixelMax[i+1] = 255;
                            pixelMax[i+2] = 0;
                        }
                    else
                        if ( b > r && b > g)
                            for(int i=index - width*4 - 4*b ; i< index - width*4 ; i+=height )
                            {
                                pixelMax[i] = 0;
                                pixelMax[i+1] = 0;
                                pixelMax[i+2] = 255;
                            }
                r=0;
                g=0;
                b=0;
                
            }
        }
    
    //error correction 3
    for (int index = width*4; index < dataLength-(width*4); index += 4)
    {
        if(pixelMax[index-width*4] != 0 && pixelMax[index-width*4] != 255)
            pixelMax[index-width*4]=0;
        
        if(pixelMax[index-width*4+1] != 0 && pixelMax[index-width*4+1] != 255)
            pixelMax[index-width*4+1]=0;
        
        if(pixelMax[index-width*4+2] != 0 && pixelMax[index-width*4+2] != 255)
            pixelMax[index-width*4+2]=255;
        
        if( pixelMax[index-width*4] == 0 && pixelMax[index-width*4+1] == 0 && pixelMax[index-width*4+2] == 0)
            pixelMax[index-width*4+2]=255;
        
    }
    
    return (pixelMax);
}

-(UIImage*)SaveImage : (UInt8*) pixelMax
{
    CGContextRef context;
	context = CGBitmapContextCreate(pixelMax,
                                    width,
                                    height,
                                    8,
                                    BytesPerRow,
                                    ColorSpace,
                                    kCGImageAlphaPremultipliedLast);
    
	CGImageRef newCGImage = CGBitmapContextCreateImage(context);
	UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
	CGContextRelease(context);
	CGImageRelease(newCGImage);
    
    //new image is newImage
    
    return(newImage);
}

@end
