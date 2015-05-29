/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * This Proxy will handle the individual epub file methods
 */

#import "ComCentogramReadiumEPubWithURLProxy.h"
#import "PackageMetadataController.h"
#import "RDContainer.h"
#import "RDPackage.h"
#import "EPubViewController.h"
#import "NavigationElementItem.h"
#import "RDContainer.h"
#import "RDNavigationElement.h"
#import "RDPackage.h"
#import "RDSpineItem.h"
#import "ContainerList.h"

@interface ComCentogramReadiumEPubWithURLProxy () <
RDContainerDelegate>
{
    @private NSMutableArray *m_items;
    @private __weak UITableView *m_table;
    @private NSMutableArray *m_sdkErrorMessages;
}

@end

@implementation ComCentogramReadiumEPubWithURLProxy

- (BOOL)container:(RDContainer *)container handleSdkError:(NSString *)message isSevereEpubError:(BOOL)isSevereEpubError {
    
    NSLog(@"[INFO] READIUM SDK: %@\n", message);
    
    if (isSevereEpubError == YES)
        [m_sdkErrorMessages addObject:message];
    
    // never throws an exception
    return YES;
}

-(void)setUrl:(id)value{
    url=[TiUtils stringValue:value];
}

-(NSDictionary *)getMetaData:(id)value{
    m_container = [[RDContainer alloc] initWithDelegate:self path:[url stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
    
    if (m_container==nil) {
        NSLog(@"[WARN] File not present at given path. Copying epub files from assets.");
        [self copyFilesToApplicationDataDir];
    }
    
    m_container = [[RDContainer alloc] initWithDelegate:self path:[url stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
    
    m_package = m_container.firstPackage;
    
     metaData=@{
                 @"title":m_package.title,
                 @"fullTitle":m_package.fullTitle,
                 @"subtitle":m_package.subtitle,
                 @"authors":m_package.authors,
                 @"language":m_package.language,
                 @"source":m_package.source,
                 @"copyrightOwner":m_package.copyrightOwner,
                 @"modificationDate":m_package.modificationDateString,
                 @"ISBN":m_package.isbn
                 };

    
    return metaData;
}

-(NSString *)url{
    return url;
}

- (void)addItem:(NavigationElementItem *)item {
    if (item.level >= 16) {
        NSLog(@"There are too many levels!");
        return;
    }
    
    [m_items addObject:item];
    
    for (RDNavigationElement *e in item.element.children) {
        [self addItem:[[NavigationElementItem alloc]
                       initWithNavigationElement:e level:item.level + 1]];
    }
}

-(void)copyFilesToApplicationDataDir{
    [ContainerList shared];
}

-(void)open:(id)args{
    m_container = [[RDContainer alloc] initWithDelegate:self path:[url stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
    
    if (m_container==nil) {
        NSLog(@"[WARN] File not present at given path. Copying epub files from assets.");
        [self copyFilesToApplicationDataDir];
    }
    m_container = [[RDContainer alloc] initWithDelegate:self path:[url stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
    m_package = m_container.firstPackage;
    
    m_items = [[NSMutableArray alloc] init];
    
    for (RDNavigationElement *e in m_package.tableOfContents.children) {
        [self addItem:[[NavigationElementItem alloc] initWithNavigationElement:e level:0]];
    }

    NavigationElementItem *item = [m_items objectAtIndex:0];
    
    if (item.element.content != nil && item.element.content.length > 0) {
        EPubViewController *c = [[EPubViewController alloc]
                                 initWithContainer:m_container
                                 package:m_package
                                 navElement:item.element];
        
        if (c != nil) {
            UINavigationController *epubViewer = [[UINavigationController alloc] initWithRootViewController:c];

            [[TiApp app] showModalController: epubViewer animated: YES];
        }
    }

}

@end
