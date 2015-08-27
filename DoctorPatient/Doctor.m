//
//  Doctor.m
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Doctor.h"

@interface Doctor()
@property (nonatomic, strong) NSMutableDictionary *localRecords;
@property (nonatomic, strong) NSMutableDictionary *allRecords;
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
        _localRecords = [NSMutableDictionary new];
        _allRecords = nil;
        
    }
    return self;
}
-(instancetype)initWithName:(NSString*)name
          andSpecialization:(NSString*)specialization
	 andPrescriptionRecords:(NSMutableDictionary *)allPrescriptions{
    self = [super init];
    if (self){
        
        if ([[name lowercaseString] hasPrefix:@"dr"] ||
            [[name lowercaseString] hasPrefix:@"doctor"] ){
	        _name = name;
        } else {
            _name = [NSString stringWithFormat:@"Dr. %@", name];
        }
        _specialization = specialization;
        _localRecords = [NSMutableDictionary new];
        _allRecords = allPrescriptions;
        
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

-(NSString*)generatePrescription{
    // generate random medication
    int frequency = arc4random_uniform(9) + 1;
    int dosage = arc4random_uniform(3) + 1;
    NSString* prescription = [NSString stringWithFormat:@"Tylenol %dx every %d hours", dosage, frequency];
    return prescription;
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
    
    NSString* prescription = [self generatePrescription];
    [self storePrescription:prescription forPatient:patient];
    
    [patient receivePrescription:prescription];
    
}

-(void)storePrescription:(NSString*)prescription forPatient:(Patient*)patient{

    NSMutableArray* previousPrescriptionsForPatient = self.localRecords[ patient.name ];
    
    if (previousPrescriptionsForPatient == nil){
        previousPrescriptionsForPatient = [NSMutableArray new];
        self.localRecords[patient.name] = previousPrescriptionsForPatient;
    }
    
    [previousPrescriptionsForPatient addObject:prescription];

    self.allRecords[ self.name ] = self.localRecords;
    
    NSLog(@"%@ stored prescription [%@] for patient %@ into records",
          self.name, prescription, patient.name);
    
}

-(void)showRecords{
    NSLog(@"RECORDS:");
    for (NSString* patientName in self.localRecords) {
        NSLog(@"Patient: %@", patientName);
        NSLog(@"%@", self.localRecords[patientName]);
    }

    
    
}


#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    Doctor *aCopy = [[Doctor allocWithZone:zone] init];
    aCopy.name = [self.name copy];
    aCopy.specialization = [self.specialization copy];
    aCopy.localRecords = [self.localRecords copy];
    aCopy.allRecords = [self.allRecords copy];

    return aCopy;
}



@end
