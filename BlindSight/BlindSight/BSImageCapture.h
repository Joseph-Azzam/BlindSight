//
//  BSImageCapture.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-11-19.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSImageCapture : NSObject

-(void)CaptureandSave;
-(void)CaptureImages:(int)numberofimages minfocusdistance:(float)minfd maxfocusdistance:(float)maxfd;

/*THE FUNCTIONS ARE SUPPOSED TO:
1-TURN USE SAME SHUTTER SPEED FOR ALL THE CAPTURES
2-TAKE AT LEAST 3 PICTURES AT DIFFERENT FOCUS POSITION
3-SAVE THE IMAGES INSIDE THE APP TEMP FOLDER
 */

@end
