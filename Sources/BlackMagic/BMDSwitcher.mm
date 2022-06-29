//
//  BMDSwitcher.m
//  BlackMagic
//
//  Created by Grant Butler on 12/9/18.
//

#import "BlackMagic/BMDSwitcher.h"
#include "BMDSwitcherAPI.h"
#import "BlackMagic/BMDError.h"

@interface BMDSwitcher () {
    IBMDSwitcher *_switcher;
}

@end

@implementation BMDSwitcher

+ (void)switcherAtAddress:(NSString *)deviceAddress completion:(void(^)(BMDSwitcher * _Nullable, NSError * _Nullable))completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSError *error;
        BMDSwitcher *switcher = [BMDSwitcher switcherAtAddress:deviceAddress error:&error];
        
        completion(switcher, error);
    });
}

+ (nullable instancetype)switcherAtAddress:(NSString *)deviceAddress error:(NSError ** _Nullable)error {
    IBMDSwitcherDiscovery *discovery = CreateBMDSwitcherDiscoveryInstance();
    if (discovery == NULL) {
        if (error) {
            *error = [NSError errorWithDomain:BMDErrorDomain code:BMDNoSDKInstalledError userInfo:nil];
        }
        return nil;
    }
    
    IBMDSwitcher *iswitcher;
    BMDSwitcherConnectToFailure connectionError = 0;
    if (discovery->ConnectTo((__bridge CFStringRef)deviceAddress, &iswitcher, &connectionError) != S_OK) {
        if (error) {
            switch (connectionError) {
            case bmdSwitcherConnectToFailureNoResponse:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorNoResponse userInfo:nil];
                break;
            case bmdSwitcherConnectToFailureIncompatibleFirmware:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorIncompatibleFirmware userInfo:nil];
                break;
            case bmdSwitcherConnectToFailureCorruptData:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorCorruptData userInfo:nil];
                break;
            case bmdSwitcherConnectToFailureStateSync:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorStateSync userInfo:nil];
                break;
            case bmdSwitcherConnectToFailureStateSyncTimedOut:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorStateSyncTimedOut userInfo:nil];
                break;
            case bmdSwitcherConnectToFailureDeprecatedAfter_v7_3:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDConnectionErrorDeprecatedAfter_v7_3 userInfo:nil];
                break;
            default:
                *error = [NSError errorWithDomain:BMDErrorDomain code:BMDUnknownError userInfo:nil];
                break;
            }
        }
        
        discovery->Release();
        return nil;
    }
    
    BMDSwitcher *switcher = [[BMDSwitcher alloc] initWithSwitcher:iswitcher];
    iswitcher->Release();
    discovery->Release();
    
    *error = nil;
    
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
