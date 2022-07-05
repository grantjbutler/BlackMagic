//
//  InputMonitor.cpp
//  
//
//  Created by Grant Butler on 7/5/22.
//

#include "InputMonitor.hpp"

InputMonitor::InputMonitor(IBMDSwitcherInput* input, BMDSwitcherInput* objcInput) {
    mInput = input;
    mObjcInput = objcInput;
    mRefCount = 1;

    mInput->AddRef();
    mInput->AddCallback(this);
}

InputMonitor::~InputMonitor() {
    mInput->RemoveCallback(this);
    mInput->Release();
}

ULONG STDMETHODCALLTYPE InputMonitor::AddRef(void) {
    return mRefCount.fetch_add(1);
}

ULONG STDMETHODCALLTYPE InputMonitor::Release(void) {
    int newCount = mRefCount.fetch_sub(1);
    if (newCount == 0)
        delete this;
    return newCount;
}

HRESULT STDMETHODCALLTYPE InputMonitor::QueryInterface(REFIID iid, LPVOID *ppv) {
    if (!ppv)
        return E_POINTER;
    
    if (CFEqual(&iid, &IID_IBMDSwitcherInputCallback))
    {
        *ppv = static_cast<IBMDSwitcherInputCallback*>(this);
        AddRef();
        return S_OK;
    }
    
    if (CFEqual(&iid, IUnknownUUID))
    {
        *ppv = static_cast<IUnknown*>(this);
        AddRef();
        return S_OK;
    }
    
    *ppv = NULL;
    return E_NOINTERFACE;
}

HRESULT InputMonitor::Notify(BMDSwitcherInputEventType eventType) {
    switch (eventType)
    {
        case bmdSwitcherInputEventTypeLongNameChanged:
            [mObjcInput willChangeValueForKey:@"longName"];
            [mObjcInput didChangeValueForKey:@"longName"];
            break;
        case bmdSwitcherInputEventTypeShortNameChanged:
            [mObjcInput willChangeValueForKey:@"shortName"];
            [mObjcInput didChangeValueForKey:@"shortName"];
            break;
        default:	// ignore other property changes not used for this sample app
            break;
    }
    
    return S_OK;
}
