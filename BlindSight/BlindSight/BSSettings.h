//
//  BSSettings.h
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSettings : NSObject

@property (nonatomic) BOOL  HorizontalScanning;
@property (nonatomic) BOOL  VerticalScanning;
@property (nonatomic) float   ScanThreshold;
@property (nonatomic) BOOL  SafePixels;
@property (nonatomic) BOOL  ErrorCorrection;
@property (nonatomic) float   ErrorCorrectionThreshold;
@property (nonatomic) int zero;

@end
