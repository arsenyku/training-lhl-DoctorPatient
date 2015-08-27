//
//  Patient.m
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Patient.h"
#import "Doctor.h"

@implementation Patient

-(instancetype)init{
    self = [super init];
    if (self){
        _name = @"";
        _age = @0;
        _healthCardId = nil;
        _doctor = nil;
        _diseases = [NSMutableArray new];
        _symptoms = [NSMutableArray new];
    }
    return self;
}


-(instancetype)initWithName:(NSString *)name
                     andAge:(NSNumber*)age{
    self = [super init];
    if (self){
        _name = name;
        _age = age;
        _healthCardId = nil;
        _doctor = nil;
        _diseases = [NSMutableArray new];
        _symptoms = [NSMutableArray new];
    }
    return self;
}


-(BOOL)isHealthy{
    return ([self.diseases count] < 1);
}

-(void)receivePrescription:(NSString *)prescription{
    NSLog(@"%@ received prescription [%@] from %@",
          self.name, prescription, self.doctor ? self.doctor.name : @"some guy in an alley.");
}

-(void)getSickAndVisitDoctor:(Doctor *)doctor{
    // Generate random symptom
    [self.symptoms addObject:@"Runny nose"];
    
    BOOL accepted = [doctor requestTreatmentForPatient:self];

    if (accepted)
    {
        NSLog(@"%@ accepted for treatment by %@ (%@ specialist)", self.name, doctor.name, doctor.specialization);
        self.doctor = doctor;

    } else {
        NSLog(@"%@ rejected for treatment by %@ (%@ specialist)", self.name, doctor.name, doctor.specialization);
    }
    
    [doctor requestMedicationForPatient:self];
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    Patient *aCopy = [[Patient allocWithZone:zone] init];
    aCopy.name = [self.name copy];
    aCopy.age = [self.age copy];
    aCopy.healthCardId = [self.healthCardId copy];
    aCopy.doctor = [self.doctor copy];
    aCopy.diseases = [self.diseases copy];
    aCopy.symptoms = [self.symptoms copy];
    
    return aCopy;
}

@end
