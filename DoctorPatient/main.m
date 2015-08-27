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
        
        [patient1 getSickAndVisitDoctor:doctorPhil];
        [patient2 getSickAndVisitDoctor:doctorPhil];
        [patient3 getSickAndVisitDoctor:doctorPhil];
        [patient1 getSickAndVisitDoctor:doctorPhil];
        [patient2 getSickAndVisitDoctor:doctorPhil];
        [patient3 getSickAndVisitDoctor:doctorPhil];
        [patient1 getSickAndVisitDoctor:doctorPhil];
        [patient2 getSickAndVisitDoctor:doctorPhil];
        
        Doctor* shadyDoctor = [[Doctor alloc] initWithName:@"Slim McShady"
                                         andSpecialization:@"Liver extraction"
                                    andPrescriptionRecords:allPrescriptions];
        
        
        Patient* shadyGuy = [[Patient alloc] initWithName:@"Leftmy Healthcardathome"
                                                   andAge:@25];
        
        [shadyGuy getSickAndVisitDoctor:doctorPhil];
        
        shadyGuy.healthCardId = @"Fake12345";
        [shadyGuy getSickAndVisitDoctor:shadyDoctor];
        
        [doctorPhil showRecords];
        [shadyDoctor showRecords];
        
        NSLog(@"%@", allPrescriptions);
    }
    return 0;
}
