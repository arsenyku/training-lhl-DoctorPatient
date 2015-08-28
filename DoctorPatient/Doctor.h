//
//  Doctor.h
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Doctor : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *specialization;

-(instancetype)initWithName:(NSString*)name
          andSpecialization:(NSString*)specialization
     andPrescriptionRecords:(NSMutableDictionary*)allPrescriptions;

-(BOOL)requestTreatmentApprovalForPatient:(Patient*)patient;
-(void)requestMedicationForPatient:(Patient*)patient;

-(void)showRecords;

@end


@interface MedicalReference: NSObject
-(NSDictionary*)infoForSymptom:(NSString*)symptom;
-(NSDictionary*)infoForDisease:(NSString*)disease;
-(NSDictionary*)infoForMedication:(NSString*)medication;
@end
