//
//  ImportOperation.m
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "ImportOperation.h"


@interface ImportOperation ()

@property (nonatomic, strong) NSArray* recordsToImport;
@property (nonatomic, strong) NSString* entityType;
@property (nonatomic, strong) NSManagedObjectContext* parentContext;
@property (nonatomic, strong) NSManagedObjectContext* privateContext;

@end

@implementation ImportOperation

- (instancetype)initWithRecordsToImport:(NSArray*)records forEntityType:(NSString*)entityType parentContext:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self)
    {
        self.parentContext = context;
        self.recordsToImport = records;
        self.privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType];
        self.privateContext.parentContext = context;
        self.entityType = entityType;
    }
    
    return self;
}

- (void)main
{
    NSLog(@"Starting Import Operation %@", self.entityType);
    
    if (self.cancelled || self.recordsToImport.count < 1)
    {
        return;
    }
    self.recordsToImport = [self.recordsToImport sortedArrayUsingComparator:^NSComparisonResult(CKRecord* obj1, CKRecord* obj2) {
         return [obj1.recordID.recordName localizedCompare:obj2.recordID.recordName] == NSOrderedAscending;
    }];
    NSMutableArray* primaryKeys = [[NSMutableArray alloc] init];
    
    for (CKRecord* record in self.recordsToImport)
    {
        [primaryKeys addObject:record.recordID.recordName];
    }
    
    NSFetchRequest* existingIds = [NSFetchRequest fetchRequestWithEntityName:self.entityType];
    existingIds.predicate = [NSPredicate predicateWithFormat:@"id IN %@", primaryKeys];
    existingIds.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]];
    existingIds.returnsObjectsAsFaults = YES;
    NSArray* records = [self.privateContext executeFetchRequest:existingIds error:nil];
    NSMutableArray* existingPrimaryKeys = [[NSMutableArray alloc] init];
    for (NSManagedObject* object in records)
    {
        [existingPrimaryKeys addObject:[object valueForKey:@"id"]];
    }
    
    for (int i = 0; i<primaryKeys.count; i++)
    {
        //Check if existing
        NSManagedObject* existing = [self objectWithID:primaryKeys[i] inArray:self.recordsToImport];
        if (existing)
        {
            [self updateAttributesForManagedObject:existing withRecord:self.recordsToImport[i]];
        }
        else
        {
            [self createWithCK:self.recordsToImport[i]];
        }
    }
    [self.privateContext save:nil];
}

- (NSManagedObject*)objectWithID:(NSString*)identifier inArray:(NSArray*)objects
{
    for (NSManagedObject* object in objects)
    {
        if ([[object valueForKey:@"id"] isEqualToString:identifier])
        {
            return object;
        }
    }
    
    return nil;
}

- (NSManagedObject*)createWithCK:(CKRecord*)record
{
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:self.entityType inManagedObjectContext:self.privateContext];
    if (entityDescription)
    {
        NSManagedObject* newMo = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.privateContext];
        
        [self updateAttributesForManagedObject:newMo withRecord:record];
    }
    return nil;
}

- (void)updateAttributesForManagedObject:(NSManagedObject*)object withRecord:(CKRecord*)record
{
    NSEntityDescription* description = object.entity;
    NSDictionary* attributes = description.attributesByName;
    for (NSString* name in attributes)
    {
        NSAttributeDescription* att = [attributes objectForKey:name];
        if (![att.name isEqualToString:@"id"])
        {
            [object setValue:[record valueForKey:name] forKey:name];
        }
        else
        {
            [object setValue:record.recordID.recordName forKey:name];
        }
    }
}



@end
