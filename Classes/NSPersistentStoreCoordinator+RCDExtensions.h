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


@interface NSPersistentStoreCoordinator (RCDExtensions)

#pragma mark - Class methods

// Returns a dictionary containing the metadata stored in the persistent store at a given URL.
+ (RACSignal *)rcd_metadataForPersistentStoreOfType:(NSString *)storeType URL:(NSURL *)url;

// Deletes all ubiquitous content for all peers for the persistent store at a given URL and also delete the local store file.
+ (RACSignal *)rcd_removeUbiquitousContentAndPersistentStoreAtURL:(NSURL *)storeURL options:(NSDictionary *)options;

// Sets the metadata for a given store.
+ (RACSignal *)rcd_setMetadata:(NSDictionary *)metadata forPersistentStoreOfType:(NSString *)storeType URL:(NSURL *)url;

#pragma mark - Instance methods

// Adds a new persistent store of a specified type at a given location, and returns the new store.
- (RACSignal *)rcd_addPersistentStoreWithType:(NSString *)storeType configuration:(NSString *)configuration URL:(NSURL *)storeURL options:(NSDictionary *)options;

// Sends a request to all the persistent stores associated with the receiver.
- (RACSignal *)rcd_executeRequest:(NSPersistentStoreRequest *)request withContext:(NSManagedObjectContext *)context;

// Moves a persistent store to a new location, changing the storage type if necessary.
- (RACSignal *)rcd_migratePersistentStore:(NSPersistentStore *)store toURL:(NSURL *)URL options:(NSDictionary *)options withType:(NSString *)storeType;

// Removes a given persistent store.
- (RACSignal *)rcd_removePersistentStore:(NSPersistentStore *)store;

#pragma mark - Notifications

- (RACSignal *)rcd_addObserverForPersistentStoreCoordinatorStoresDidChangeNotification;
- (RACSignal *)rcd_addObserverForPersistentStoreCoordinatorStoresWillChangeNotification;
- (RACSignal *)rcd_addObserverForPersistentStoreCoordinatorWillRemoveStoreNotification;
- (RACSignal *)rcd_addObserverForPersistentStoreDidImportUbiquitousContentChangesNotification;

@end
