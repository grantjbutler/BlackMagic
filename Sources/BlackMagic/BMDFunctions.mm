//
//  BMDFunctions.m
//  BlackMagic
//
//  Created by Grant Butler on 12/9/18.
//

#import "BlackMagic/BMDFunctions.h"
#include "BMDSwitcherAPI.h"

BOOL BMDIsSDKInstalled(void) {
    IBMDSwitcherDiscovery *discovery = CreateBMDSwitcherDiscoveryInstance();
    if (!discovery) {
        return NO;
    }
    
    discovery->Release();
    return YES;
}
