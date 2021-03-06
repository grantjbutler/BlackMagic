//
//  BMDSwitcher.h
//  BlackMagic
//
//  Created by Grant Butler on 12/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDSwitcher : NSObject

+ (nullable instancetype)switcherAtAddress:(NSString *)deviceAddress;

@property (strong, readonly) NSString *productName;

@end

NS_ASSUME_NONNULL_END
