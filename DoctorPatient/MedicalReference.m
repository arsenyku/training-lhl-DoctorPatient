//
//  MedicalReference.m
//  DoctorPatient
//
//  Created by asu on 2015-08-29.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "MedicalReference.h"

@interface MedicalReference()
@property (nonatomic, strong) NSMutableArray *knownDiseases;
@property (nonatomic, strong) NSMutableArray *knownMedications;
@property (nonatomic, strong) NSMutableArray *knownSymptoms;
@end


@implementation MedicalReference


-(instancetype)init{
    self = [super init];
    if (self){
        _knownDiseases = [NSMutableArray new];
        _knownMedications = [NSMutableArray new];
        _knownSymptoms = [NSMutableArray new];
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

-(void)addResearchInfoForDisease:(NSString*)disease
                      andSymptom:(NSString*)symptom
                   andMedication:(NSString*)medication{

    [self.knownDiseases addObject:disease];
    [self.knownMedications addObject:medication];
    [self.knownSymptoms addObject:symptom];
 
}

-(NSArray*)listKnownSymptoms{
    return [self.knownSymptoms copy];
}


+(instancetype)standardReference{
    MedicalReference *result = [MedicalReference new];
    [result addResearchInfoForDisease:@"Malaria"        andSymptom:@"Runny nose"      andMedication:@"Tylenol"  ];
    [result addResearchInfoForDisease:@"Common Cold"    andSymptom:@"Fever"           andMedication:@"Valium"   ];
    [result addResearchInfoForDisease:@"Tuberculosis"   andSymptom:@"Rashes"          andMedication:@"Claritin" ];
    [result addResearchInfoForDisease:@"Polio" 		    andSymptom:@"Irritable Skin"  andMedication:@"Morphine" ];
    [result addResearchInfoForDisease:@"Typhoid Fever"  andSymptom:@"Red Eyes"        andMedication:@"Heroin"   ];
    return result;
}

@end

