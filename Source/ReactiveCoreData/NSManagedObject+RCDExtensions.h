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


@interface NSManagedObject (RCDExtensions)

#pragma mark - Validation

// Returns a signal that completes if the receiver can be deleted in its current state; sends an error otherwise.
- (RACSignal *)rcd_validateForDelete;

// Returns a signal that completes if the receiver can be inserted in its current state; sends an error otherwise.
- (RACSignal *)rcd_validateForInsert;

// Returns a signal that completes if the receiver is valid; sends an error otherwise.
- (RACSignal *)rcd_validateForUpdate;

// Returns a signal that completes if the property value for a given key is valid; sends an error otherwise.
- (RACSignal *)rcd_validateValue:(id *)value forKey:(NSString *)key;

@end
