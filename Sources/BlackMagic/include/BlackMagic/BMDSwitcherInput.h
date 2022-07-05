//
//  BMDSwitcherInput.h
//  
//
//  Created by Grant Butler on 7/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDSwitcherInput : NSObject

@property (copy, readonly) NSString *shortName;
@property (copy, readonly) NSString *longName;
@property (readonly) BOOL isPreviewTallied;
@property (readonly) BOOL isProgramTallied;

@end

NS_ASSUME_NONNULL_END
