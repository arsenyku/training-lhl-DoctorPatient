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
        _disease = @"";
        _symptom = @"";
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
        _disease = @"";
        _symptom = @"";
    }
    return self;
}




-(void)receivePrescription:(NSString *)prescription{
    NSLog(@"%@ received prescription [%@] from %@",
          self.name, prescription, self.doctor ? self.doctor.name : @"some guy in an alley.");
}

-(void)getSickWithSymptom:(NSString*)symptom andVisitDoctor:(Doctor *)doctor{
    self.symptom = symptom;
    
    BOOL accepted = [doctor requestTreatmentApprovalForPatient:self];

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
    aCopy.disease = [self.disease copy];
    aCopy.symptom = [self.symptom copy];
    
    return aCopy;
}

@end
