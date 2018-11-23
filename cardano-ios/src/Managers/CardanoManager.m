//
//  CardanoManager.m
//  cardano-ios
//
//  Created by Ivan Manov on 23/11/2018.
//
//------------------------------------------//

#import "CardanoManager.h"

//------------------------------------------//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#import "libcardano.h"

//------------------------------------------//

@interface CardanoManager ()

@end

//------------------------------------------//

@implementation CardanoManager

+ (instancetype)shared {
    static id sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

- (id)init {
    if (self = [super init]) {
    } return self;
}

#pragma mark - Public methods

- (BOOL)validateCardanoAddress:(NSString *)address {
    if (address && [address isKindOfClass:NSString.class]) {
        return !cardano_address_is_valid([address cStringUsingEncoding:NSUTF8StringEncoding]);
    } return NO;
}

@end

//------------------------------------------//
