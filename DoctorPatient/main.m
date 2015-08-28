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
        
        
//        @"Runny nose",
//        @"Fever",
//        @"Rashes",
//        @"Irritable Skin",
//        @"Red Eyes"
        
        [patient1 getSickWithSymptom:@"Runny nose" andVisitDoctor:doctorPhil];
        [patient2 getSickWithSymptom:@"Fever" andVisitDoctor:doctorPhil];
        [patient3 getSickWithSymptom:@"Rashes" andVisitDoctor:doctorPhil];
        [patient1 getSickWithSymptom:@"Irritable Skin" andVisitDoctor:doctorPhil];
        [patient2 getSickWithSymptom:@"Red Eyes" andVisitDoctor:doctorPhil];
        [patient3 getSickWithSymptom:@"Runny nose" andVisitDoctor:doctorPhil];
        [patient1 getSickWithSymptom:@"Fever" andVisitDoctor:doctorPhil];
        [patient2 getSickWithSymptom:@"Rashes" andVisitDoctor:doctorPhil];
        
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
