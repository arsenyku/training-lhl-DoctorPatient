//
//  Patient.h
//  DoctorPatient
//
//  Created by asu on 2015-08-27.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Doctor;

@interface Patient : NSObject <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *healthCardId;
@property (nonatomic, strong) Doctor *doctor;

@property (nonatomic, strong) NSMutableArray* diseases;
@property (nonatomic, strong) NSMutableArray* symptoms;

-(instancetype)initWithName:(NSString *)name
                     andAge:(NSNumber*)age;

-(BOOL)isHealthy;
-(void)receivePrescription:(NSString*)prescription;
-(void)getSickAndVisitDoctor:(Doctor*)doctor;

@end
