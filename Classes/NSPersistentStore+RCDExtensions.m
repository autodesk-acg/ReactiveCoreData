/********************************************************************
 * (C) Copyright 2013 by Autodesk, Inc. All Rights Reserved. By using
 * this code,  you  are  agreeing  to the terms and conditions of the
 * License  Agreement  included  in  the documentation for this code.
 * AUTODESK  MAKES  NO  WARRANTIES,  EXPRESS  OR  IMPLIED,  AS TO THE
 * CORRECTNESS OF THIS CODE OR ANY DERIVATIVE WORKS WHICH INCORPORATE
 * IT.  AUTODESK PROVIDES THE CODE ON AN 'AS-IS' BASIS AND EXPLICITLY
 * DISCLAIMS  ANY  LIABILITY,  INCLUDING CONSEQUENTIAL AND INCIDENTAL
 * DAMAGES  FOR ERRORS, OMISSIONS, AND  OTHER  PROBLEMS IN THE  CODE.
 *
 * Use, duplication,  or disclosure by the U.S. Government is subject
 * to  restrictions  set forth  in FAR 52.227-19 (Commercial Computer
 * Software Restricted Rights) as well as DFAR 252.227-7013(c)(1)(ii)
 * (Rights  in Technical Data and Computer Software),  as applicable.
 *******************************************************************/

#import "NSPersistentStore+RCDExtensions.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation NSPersistentStore (RCDExtensions)

// Returns the metadata from the persistent store at the given URL.
+ (RACSignal *)rcd_metadataForPersistentStoreWithURL:(NSURL *)url
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        NSDictionary *result = [self metadataForPersistentStoreWithURL:url error:&error];
        if (error) {
            [subscriber sendError:error];
        } else {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

// Sets the metadata for the store at a given URL.
+ (RACSignal *)rcd_setMetadata:(NSDictionary *)metadata forPersistentStoreWithURL:(NSURL *)url
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self setMetadata:metadata forPersistentStoreWithURL:url error:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

// Instructs the receiver to load its metadata.
- (RACSignal *)rcd_loadMetadata
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self loadMetadata:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

@end
