/********************************************************************
 * (C) Copyright 2014 by Autodesk, Inc. All Rights Reserved. By using
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

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "NSNotificationCenter+RCDExtensions.h"


@implementation NSNotificationCenter (RCDExtensions)

- (RACSignal *)rcd_addObserverForName:(NSString *)notificationName object:(id)object {
    @weakify(object);
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(object);
        id observer = [self addObserverForName:notificationName object:object queue:nil usingBlock:^(NSNotification *note) {
            [subscriber sendNext:note];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [self removeObserver:observer];
        }];
    }] setNameWithFormat:@"-rcd_addObserverForName: %@ object: <%@: %p>", notificationName, [object class], object];
}

@end
