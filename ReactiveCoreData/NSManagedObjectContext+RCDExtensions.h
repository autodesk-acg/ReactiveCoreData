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

#import <CoreData/CoreData.h>

@class RACSignal;


@interface NSManagedObjectContext (RCDExtensions)

#pragma mark - Operations

- (RACSignal *)adr_countForFetchRequest:(NSFetchRequest *)request;
- (RACSignal *)adr_executeFetchRequest:(NSFetchRequest *)request;
- (RACSignal *)adr_existingObjectWithID:(NSManagedObjectID *)objectID;
- (RACSignal *)adr_obtainPermanentIDsForObjects:(NSArray *)objects;
- (RACSignal *)adr_save;

#pragma mark - Notifications

// Returns a signal whose next value is an (NSNotification *) when values of properties of objects contained in
// the managed object context are changed.
// The notification object is the managed object context. The userInfo dictionary contains the following
// keys: NSInsertedObjectsKey, NSUpdatedObjectsKey, and NSDeletedObjectsKey.
- (RACSignal *)adr_addObserverForObjectsDidChangeNotification;

// Returns a signal whose next value is an (NSNotification *) when a save operation completes for this
// managed object context. You would typically subscribe to this in a parent thread to listen to the MOC
// save notifications of the child thread. Be sure to schedule the result on the parent thread.
// e.g.
//    @weakify(self);
//    [[[managedObjectContextForThread adr_addObserverForDidSaveNotification]
//      deliverOn:[RACScheduler mainThreadScheduler]] // <-- Schedules on the parent thread
//     subscribeNext:^(NSNotification *saveNotification) {
//         // Merge any changes into the parent thread's managed object context.
//         @strongify(self);
//         [self.managedObjectContext mergeChangesFromContextDidSaveNotification:saveNotification];
//     }];
// The notification object is the managed object context. The userInfo dictionary contains the following
// keys: NSInsertedObjectsKey, NSUpdatedObjectsKey, and NSDeletedObjectsKey.
- (RACSignal *)adr_addObserverForDidSaveNotification;

// Returns a signal whose next value is an (NSNotification *) whenever the managed object context is
// about to perform a save operation.
// The notification object is the managed object context. There is no userInfo dictionary.
- (RACSignal *)adr_addObserverForWillSaveNotification;

@end
