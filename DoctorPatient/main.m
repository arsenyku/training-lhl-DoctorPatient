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

        Doctor* doctorPhil = [[Doctor alloc] initWithName:@"Phil"
                                    andSpecialization:@"Quack"];
        Patient* patient = [[Patient alloc] initWithName:@"Sneezy"
                                                  andAge:@132];
        patient.healthCardId = @"12345";
        [patient getSickAndVisitDoctor:doctorPhil];

        Patient* shadyGuy = [[Patient alloc] initWithName:@"Leftmy Healthcardathome"
                                                   andAge:@25];
        
        [shadyGuy getSickAndVisitDoctor:doctorPhil];
    }
    return 0;
}
