//
//  Doctor.m
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Doctor.h"

@interface Doctor()
@property (nonatomic, strong) NSMutableDictionary *records;
@end

@implementation Doctor

//NSArray *knownDiseases = @[ @"Malaria",
//                            @"Common Cold",
//                            @"Tuberculosis",
//                            @"Polio",
//                            @"Typhoid Fever"];
//
//NSArray *knownMedications = @[ @"Tylenol",
//                               @"Valium",
//                               @"Drug1",
//                               @"Drug2"
//                               @"Drug3" ];
//
//NSArray *knownSymptoms = @[ @"Runny nose",
//                            @"Fever",
//                            @"Rashes",
//                            @"Irritable Skin",
//                            @"Red Eyes",
//                            @"Sneezing"]

-(instancetype)init{
    self = [super init];
    if (self){
        
    	_name = @"";
        _specialization = @"";
        _records = [NSMutableDictionary new];
        
    }
    return self;
}
-(instancetype)initWithName:(NSString*)name
          andSpecialization:(NSString*)specialization{
    self = [super init];
    if (self){
        
        if ([[name lowercaseString] hasPrefix:@"dr"] ||
            [[name lowercaseString] hasPrefix:@"doctor"] ){
	        _name = name;
        } else {
            _name = [NSString stringWithFormat:@"Dr. %@", name];
        }
        _specialization = specialization;
        _records = [NSMutableDictionary new];
        
    }
    return self;
}

-(BOOL)canTreatPatient:(Patient*)patient{
    return ( patient.healthCardId &&
            ! [patient.healthCardId isEqualToString:@""] );
}

-(BOOL)requestTreatmentForPatient:(Patient*)patient{
    return [self canTreatPatient:patient];
}

-(void)requestMedicationForPatient:(Patient*)patient{
	if ( ! [self canTreatPatient:patient] )
    {
        NSLog(@"%@ Calling security to eject patient %@", self.name, patient.name);
        return;
    }
    
    NSLog(@"%@ Treating patient %@ for symptoms %@",
          self.name,
          patient.name,
          [patient.symptoms componentsJoinedByString:@", "]);
    
    // generate random medication
    NSString* prescription =@"Tylenol 2x every 8 hours";
    
    [self storePrescription:prescription forPatient:patient];
    
    [patient receivePrescription:prescription];
    
}

-(void)storePrescription:(NSString*)prescription forPatient:(Patient*)patient{
	
    NSMutableArray* previousPrescriptionsForPatient = self.records[ patient ];
    
    if (previousPrescriptionsForPatient == nil){
        previousPrescriptionsForPatient = [NSMutableArray new];
        self.records[patient] = previousPrescriptionsForPatient;
    }
    
    [previousPrescriptionsForPatient addObject:prescription];
    
    NSLog(@"%@ stored prescription [%@] for patient %@ into records",
          self.name, prescription, patient.name);
    
}


#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    Doctor *aCopy = [[Doctor allocWithZone:zone] init];
    aCopy.name = [self.name copy];
    aCopy.specialization = [self.specialization copy];
    aCopy.records = [self.records copy];

    return aCopy;
}



@end
