//
//  BMDSwitcherInput.m
//  
//
//  Created by Grant Butler on 7/5/22.
//

#include "BMDSwitcherAPI.h"
#import "BlackMagic/BMDSwitcherInput.h"

@interface BMDSwitcherInput () {
    IBMDSwitcherInput *_input;
}

@end

@implementation BMDSwitcherInput

- (instancetype)initWithInput:(IBMDSwitcherInput *)input {
    self = [super init];
    if (self) {
        input->AddRef();
        _input = input;
    }
    return self;
}

- (void)dealloc {
    _input->Release();
}

- (NSString *)shortName {
    CFStringRef productName;
    if (FAILED(_input->GetShortName(&productName))) {
        return @"";
    }
    
    return (__bridge NSString *)productName;
}

- (NSString *)longName {
    CFStringRef productName;
    if (FAILED(_input->GetLongName(&productName))) {
        return @"";
    }
    
    return (__bridge NSString *)productName;
}

- (BOOL)isPreviewTallied {
    bool isTallied;
    return SUCCEEDED(_input->IsPreviewTallied(&isTallied)) ? isTallied : false;
}

- (BOOL)isProgramTallied {
    bool isTallied;
    return SUCCEEDED(_input->IsProgramTallied(&isTallied)) ? isTallied : false;
}

@end
