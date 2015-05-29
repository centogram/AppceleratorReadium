/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * This Proxy will handle the individual epub file methods.
 */
#import "TiProxy.h"

@class RDContainer;
@class RDNavigationElement;
@class RDPackage;

@interface ComCentogramReadiumEPubWithURLProxy : TiProxy {
    NSDictionary * metaData;
    NSString *url;
    @private RDContainer *m_container;
    @private RDNavigationElement *m_element;
    @private RDPackage *m_package;
}

@end
