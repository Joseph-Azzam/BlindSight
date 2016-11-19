//
//  BSSettings.m
//  BlindSight
//
//  Created by Joseph Azzam on 2013-12-26.
//  Copyright (c) 2013 Joseph Azzam. All rights reserved.
//

#import "BSSettings.h"

@implementation BSSettings

@synthesize HorizontalScanning;
@synthesize VerticalScanning;
@synthesize ScanThreshold;
@synthesize SafePixels;
@synthesize ErrorCorrection;
@synthesize ErrorCorrectionThreshold;
@synthesize zero;

-(id)init
{
    self = [super init];
    if (self) {
        HorizontalScanning = YES;
        VerticalScanning = YES;
        ScanThreshold = 40;
        SafePixels = YES;
        ErrorCorrection = NO;
        ErrorCorrectionThreshold = 2;
        zero = 2;
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeBool:HorizontalScanning forKey:@"BSSettingHS"];
    [coder encodeBool:VerticalScanning forKey:@"BSSettingVS"];
    [coder encodeFloat:ScanThreshold forKey:@"BSSettingST"];
    [coder encodeBool:SafePixels forKey:@"BSSettingSP"];
    [coder encodeBool:ErrorCorrection forKey:@"BSSettingEC"];
    [coder encodeFloat:ErrorCorrectionThreshold forKey:@"BSSettingECT"];
    [coder encodeInt:zero forKey:@"BSSettingZ"];
}

- (id)initWithCoder:(NSCoder *)coder
{

        HorizontalScanning = [coder decodeBoolForKey:@"BSSettingHS"];
        VerticalScanning   = [coder decodeBoolForKey:@"BSSettingVS"];
        ScanThreshold      = [coder decodeFloatForKey:@"BSSettingST"];
        SafePixels         = [coder decodeBoolForKey:@"BSSettingSP"];
        ErrorCorrection    = [coder decodeBoolForKey:@"BSSettingEC"];
        ErrorCorrectionThreshold = [coder decodeFloatForKey:@"BSSettingECT"];
        zero               = [coder decodeIntForKey:@"BSSettingZ"];

    return self;
}

@end
