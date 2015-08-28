//
//  Doctor.m
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Doctor.h"

@interface MedicalReference()
@property (nonatomic, strong) NSArray *knownDiseases;
@property (nonatomic, strong) NSArray *knownMedications;
@property (nonatomic, strong) NSArray *knownSymptoms;
@end

@implementation MedicalReference


-(instancetype)init{
    self = [super init];
    if (self){
        self.knownDiseases = @[ @"Malaria",
                                @"Common Cold",
                                @"Tuberculosis",
                                @"Polio",
                                @"Typhoid Fever"];
        
        self.knownMedications = @[ @"Tylenol",
                                   @"Valium",
                                   @"Claritin",
                                   @"Morphine",
                                   @"Heroin" ];
        
        self.knownSymptoms = @[ @"Runny nose",
                                @"Fever",
                                @"Rashes",
                                @"Irritable Skin",
                                @"Red Eyes"];
    }
    
    return self;
}

-(NSDictionary*)infoForTarget:(id)target inArray:(NSArray*)array{
    unsigned long targetIndex = [array indexOfObject:target];
    if (targetIndex == -1)
        return nil;
    
    NSDictionary *result = @{ @"symptom":self.knownSymptoms[targetIndex],
                              @"disease":self.knownDiseases[targetIndex],
                              @"medication":self.knownMedications[targetIndex] };
    
    return result;
}

-(NSDictionary*)infoForSymptom:(NSString*)symptom{
    return [self infoForTarget:symptom inArray:self.knownSymptoms];
}

-(NSDictionary*)infoForDisease:(NSString*)disease{
    return [self infoForTarget:disease inArray:self.knownDiseases];
}

-(NSDictionary*)infoForMedication:(NSString*)medication{
    return [self infoForTarget:medication inArray:self.knownMedications];
}
@end


@interface Doctor()
@property (nonatomic, strong) NSMutableDictionary *localRecords;
@property (nonatomic, strong) NSMutableDictionary *allRecords;
@property (nonatomic, strong) MedicalReference *book;
@property (nonatomic, strong) NSMutableArray *approvedPatients;
@end

@implementation Doctor

-(instancetype)init{
    self = [super init];
    if (self){
        
    	_name = @"";
        _specialization = @"";
        _localRecords = [NSMutableDictionary new];
        _allRecords = nil;
        _book = [MedicalReference new];
        _approvedPatients = [NSMutableArray new];
        
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
        _book = [MedicalReference new];
        _approvedPatients = [NSMutableArray new];

        
    }
    return self;
}

-(BOOL)canTreatPatient:(Patient*)patient{
    return ( patient.healthCardId &&
            ! [patient.healthCardId isEqualToString:@""] );
}



-(BOOL)requestTreatmentApprovalForPatient:(Patient*)patient{
    BOOL canTreat = [self canTreatPatient:patient];
    
    if (canTreat && [self.approvedPatients indexOfObject:patient] == NSNotFound)
        [self.approvedPatients addObject:patient];
    
    return canTreat;
}

-(NSString*)generatePrescriptionForSymptom:(NSString*)symptom{
    // generate random medication
    int frequency = arc4random_uniform(9) + 1;
    int dosage = arc4random_uniform(3) + 1;
    
    NSDictionary* diagnosis = [self.book infoForSymptom:symptom];
    
    NSString* prescription = [NSString stringWithFormat:@"%@ %dx every %d hours", diagnosis[@"medication"], dosage, frequency];
    return prescription;
}

-(void)requestMedicationForPatient:(Patient*)patient{
    if ( [self canTreatPatient:patient] &&
         [self.approvedPatients indexOfObject:patient] != NSNotFound )
    {
        NSLog(@"%@ Treating patient %@ for symptom %@",
              self.name, patient.name, patient.symptom);
        
        NSString* prescription = [self generatePrescriptionForSymptom:patient.symptom];
        [self storePrescription:prescription forPatient:patient];
        
        [patient receivePrescription:prescription];

    
    } else {
        NSLog(@"%@ cannot give medication without first approving %@", self.name, patient.name);
        return;
    }
    
    
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
