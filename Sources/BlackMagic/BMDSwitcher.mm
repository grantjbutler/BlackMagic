//
//  BMDSwitcher.m
//  BlackMagic
//
//  Created by Grant Butler on 12/9/18.
//

#import "BlackMagic/BMDSwitcher.h"
#include "BMDSwitcherAPI.h"

@interface BMDSwitcher () {
    IBMDSwitcher *_switcher;
}

@end

@implementation BMDSwitcher

+ (void)switcherAtAddress:(NSString *)deviceAddress completion:(void(^)(BMDSwitcher * _Nullable))completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        completion([BMDSwitcher switcherAtAddress:deviceAddress]);
    });
}

+ (nullable instancetype)switcherAtAddress:(NSString *)deviceAddress {
    IBMDSwitcherDiscovery *discovery = CreateBMDSwitcherDiscoveryInstance();
    if (discovery == NULL) {
        return nil;
    }
    
    IBMDSwitcher *iswitcher;
    if (discovery->ConnectTo((__bridge CFStringRef)deviceAddress, &iswitcher, NULL) != S_OK) {
        discovery->Release();
        return nil;
    }
    
    BMDSwitcher *switcher = [[BMDSwitcher alloc] initWithSwitcher:iswitcher];
    iswitcher->Release();
    discovery->Release();
    return switcher;
}

- (instancetype)initWithSwitcher:(IBMDSwitcher *)switcher {
    self = [super init];
    if (self) {
        switcher->AddRef();
        _switcher = switcher;
    }
    return self;
}

- (void)dealloc {
    _switcher->Release();
}

- (NSString *)productName {
    CFStringRef productName;
    if (_switcher->GetProductName(&productName) != S_OK) {
        return @"";
    }
    
    return (__bridge NSString *)productName;
}

@end
