//
//  InputMonitor.hpp
//  
//
//  Created by Grant Butler on 7/5/22.
//

#ifndef InputMonitor_hpp
#define InputMonitor_hpp

#include <atomic>
#include <stdio.h>
#import <CoreFoundation/CFPlugInCOM.h>

#include "BMDSwitcherAPI.h"
#import "BMDSwitcherInput+Private.h"

class InputMonitor : public IBMDSwitcherInputCallback
{
    public:
        InputMonitor(IBMDSwitcherInput* input, BMDSwitcherInput* objcInput);
        
        IBMDSwitcherInput *mInput;
        BMDSwitcherInput *mObjcInput;
        std::atomic<int> mRefCount;
        
        HRESULT STDMETHODCALLTYPE QueryInterface(REFIID iid, LPVOID *ppv);
        ULONG STDMETHODCALLTYPE AddRef(void);
        ULONG STDMETHODCALLTYPE Release(void);
        
        HRESULT Notify(BMDSwitcherInputEventType eventType);
    protected:
        ~InputMonitor();
};

#endif /* InputMonitor_hpp */
