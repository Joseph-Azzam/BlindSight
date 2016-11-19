//
//  BSImageCapture.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "BSImageCapture.h"
#import <AVFoundation/AVCaptureDevice.h>

@implementation BSImageCapture
-(void)CaptureandSave{};
-(void)CaptureImages:(int)numbersfimages minfocusdistance:(float)minfd maxfocusdistance:(float)maxfd{};
 /*
{
    self.imagePickerController takePicture;
}
}
-(void)CaptureImages:(int)numbersfimages minfocusdistance:(float)minfd maxfocusdistance:(float)maxfd;
{
    float step;
    float position = minfd;
    step = ( maxfd - minfd ) / numbersfimages ;
    for(int i = 0 ; i< numbersfimages ; i++ )
    {
    if(setFocusPosition:position)
        {
            CaptureandSave;
        }
        position = position + step ;
    }
}
*/
@end
