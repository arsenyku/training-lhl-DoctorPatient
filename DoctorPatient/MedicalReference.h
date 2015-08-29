//
//  MedicalReference.h
//  DoctorPatient
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalReference : NSObject

-(NSDictionary*)infoForSymptom:(NSString*)symptom;
-(NSDictionary*)infoForDisease:(NSString*)disease;
-(NSDictionary*)infoForMedication:(NSString*)medication;

-(void)addResearchInfoForDisease:(NSString*)disease
                      andSymptom:(NSString*)symptom
                   andMedication:(NSString*)medication;

-(NSArray*)listKnownSymptoms;

+(instancetype)standardReference;

@end
