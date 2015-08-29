//
//  main.m
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"
#import "MedicalReference.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSMutableDictionary *allPrescriptions = [NSMutableDictionary new];
        
        Doctor* doctorPhil = [[Doctor alloc] initWithName:@"Phil"
                                    	andSpecialization:@"Quack"
                                   andPrescriptionRecords:allPrescriptions];
        
        Patient* patient1 = [[Patient alloc] initWithName:@"Sneezy"
                                                  andAge:@132];
        patient1.healthCardId = @"12345";
        Patient* patient2 = [[Patient alloc] initWithName:@"Sleepy"
                                                  andAge:@132];
        patient2.healthCardId = @"09876";
        Patient* patient3 = [[Patient alloc] initWithName:@"Dopey"
                                                  andAge:@132];
        patient3.healthCardId = @"76543";
        
        NSArray* patients = @[ patient1, patient2, patient3 ];
        NSArray* symptoms = [[MedicalReference standardReference] listKnownSymptoms];


        int symptomNumber = 0;

        for (int i=0; i < 4; i++){
            for (Patient *patient in patients) {
                NSString* symptom = symptoms[ symptomNumber % [symptoms count] ];
                [patient getSickWithSymptom:symptom andVisitDoctor:doctorPhil];
                symptomNumber ++;
            }
        }
        
        Doctor* shadyDoctor = [[Doctor alloc] initWithName:@"Slim McShady"
                                         andSpecialization:@"Liver extraction"
                                    andPrescriptionRecords:allPrescriptions];
        
        
        Patient* shadyGuy = [[Patient alloc] initWithName:@"Leftmy Healthcardathome"
                                                   andAge:@25];
        
        [shadyGuy getSickWithSymptom:@"Irritable Skin" andVisitDoctor:doctorPhil];
        
        shadyGuy.healthCardId = @"Fake12345";
        [shadyGuy getSickWithSymptom:@"Runny nose" andVisitDoctor:shadyDoctor];
        
        [doctorPhil showRecords];
        [shadyDoctor showRecords];
        
        NSLog(@"%@", allPrescriptions);
    }
    return 0;
}
