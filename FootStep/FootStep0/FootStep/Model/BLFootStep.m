//
//  BLFootStep.m
//  BanLv
//
//  Created by Qianrun on 16/10/25.
//  Copyright © 2016年 刘飞. All rights reserved.
//

#import "BLFootStep.h"

@implementation BLFootStep

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    
    return YES;
}

+ (void)getFootStepWithArray:(NSArray *)source block:(void (^)(NSArray *))block {
    
    
     NSError *error = nil;
     
     NSArray *footSteps = [BLFootStep arrayOfModelsFromDictionaries:source error:&error];
     
     block(error ? nil : footSteps);
}



- (void)setEventmember:(NSArray<BLEventMember> *)eventmember {
    
    _eventmember = eventmember;
    
    NSString *membersName = @"";
    
    for (BLEventMember *member in _eventmember) {
        membersName = [membersName stringByAppendingString:[NSString stringWithFormat:@"%@，", member.membername]];
    }
    
    if (membersName.length) {
        membersName = [membersName substringToIndex:(membersName.length - 1)];
    }
    self.membersName = membersName;
}
@end