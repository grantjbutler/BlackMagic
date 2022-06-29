//
//  BMDError.h
//  
//
//  Created by Grant Butler on 6/28/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern const NSErrorDomain BMDErrorDomain;

NS_ERROR_ENUM(BMDErrorDomain) {
    BMDUnknownError = 1,
    BMDNoSDKInstalledError = 2,

    BMDConnectionErrorNoResponse = 101,
    BMDConnectionErrorIncompatibleFirmware = 102,
    BMDConnectionErrorCorruptData = 103,
    BMDConnectionErrorStateSync = 104,
    BMDConnectionErrorStateSyncTimedOut = 105,
    BMDConnectionErrorDeprecatedAfter_v7_3 = 106,
};

NS_ASSUME_NONNULL_END
