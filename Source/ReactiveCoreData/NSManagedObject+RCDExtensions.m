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

#import "NSManagedObject+RCDExtensions.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation NSManagedObject (RCDExtensions)

#pragma mark - Validation

- (RACSignal *)rcd_validateForDelete
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self validateForDelete:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

- (RACSignal *)rcd_validateForInsert
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self validateForInsert:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

- (RACSignal *)rcd_validateForUpdate
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self validateForUpdate:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

- (RACSignal *)rcd_validateValue:(id *)value forKey:(NSString *)key
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *error;
        if ([self validateValue:value forKey:key error:&error]) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

@end
