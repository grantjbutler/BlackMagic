//
//  BMDFunctions.m
//  BlackMagic
//
//  Created by Grant Butler on 12/9/18.
//

#import "BlackMagic/BMDFunctions.h"
#include "BMDSwitcherAPI.h"

BOOL BMDIsSDKInstalled(void) {
    return CreateBMDSwitcherDiscoveryInstance() != NULL;
}
