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

#import "NSManagedObjectContext+RCDExtensions.h"

#import <ReactiveCocoa/NSNotificationCenter+RACSupport.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>



@implementation NSManagedObjectContext (RCDExtensions)

#pragma mark - Instance methods

- (RACSignal *)rcd_countForFetchRequest:(NSFetchRequest *)request
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        void (^operation)(void) = ^{
            @strongify(self);
            NSError *error;
            NSUInteger count = [self countForFetchRequest:request error:&error];
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:@(count)];
                [subscriber sendCompleted];
            }
        };
        
        if (NSPrivateQueueConcurrencyType == self.concurrencyType || NSMainQueueConcurrencyType == self.concurrencyType) {
            [self performBlock:operation];
        } else {
            operation();
        }
        
        return nil;
    }];
}

- (RACSignal *)rcd_executeFetchRequest:(NSFetchRequest *)request
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        void (^operation)(void) = ^{
            @strongify(self);
            NSError *error;
            NSArray *array = [self executeFetchRequest:request error:&error];
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            }
        };
        
        if (NSPrivateQueueConcurrencyType == self.concurrencyType || NSMainQueueConcurrencyType == self.concurrencyType) {
            [self performBlock:operation];
        } else {
            operation();
        }
        
        return nil;
    }];
}

- (RACSignal *)rcd_existingObjectWithID:(NSManagedObjectID *)objectID
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        void (^operation)(void) = ^{
            @strongify(self);
            NSError *error;
            NSManagedObject *object = [self existingObjectWithID:objectID error:&error];
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:object];
                [subscriber sendCompleted];
            }
        };
        
        if (NSPrivateQueueConcurrencyType == self.concurrencyType || NSMainQueueConcurrencyType == self.concurrencyType) {
            [self performBlock:operation];
        } else {
            operation();
        }
        
        return nil;
    }];
}

- (RACSignal *)rcd_obtainPermanentIDsForObjects:(NSArray *)objects
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        void (^operation)(void) = ^{
            @strongify(self);
            NSError *error;
            BOOL wasSuccessful = [self obtainPermanentIDsForObjects:objects error:&error];
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:@(wasSuccessful)];
                [subscriber sendCompleted];
            }
        };
        
        if (NSPrivateQueueConcurrencyType == self.concurrencyType || NSMainQueueConcurrencyType == self.concurrencyType) {
            [self performBlock:operation];
        } else {
            operation();
        }
        
        return nil;
    }];
}

- (RACSignal *)rcd_save
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        void (^operation)(void) = ^{
            @strongify(self);
            if ([self hasChanges]) {
                NSError *error;
                if ([self save:&error]) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            } else {
                [subscriber sendCompleted];
            }
        };
        
        if (NSPrivateQueueConcurrencyType == self.concurrencyType || NSMainQueueConcurrencyType == self.concurrencyType) {
            [self performBlock:operation];
        } else {
            operation();
        }
        
        return nil;
    }];
}

#pragma mark - Notifications

- (RACSignal *)rcd_addObserverForObjectsDidChangeNotification
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    return [notificationCenter rac_addObserverForName:NSManagedObjectContextObjectsDidChangeNotification
                                               object:self];
}

- (RACSignal *)rcd_addObserverForDidSaveNotification
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    return [notificationCenter rac_addObserverForName:NSManagedObjectContextDidSaveNotification
                                               object:self];
}

- (RACSignal *)rcd_addObserverForWillSaveNotification
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    return [notificationCenter rac_addObserverForName:NSManagedObjectContextWillSaveNotification
                                               object:self];
}

@end
