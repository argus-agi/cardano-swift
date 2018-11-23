//
//  CardanoManager.h
//  cardano-ios
//
//  Created by Ivan Manov on 23/11/2018.
//
//------------------------------------------//

#import <Foundation/Foundation.h>

//------------------------------------------//

NS_ASSUME_NONNULL_BEGIN

@interface CardanoManager : NSObject

+ (instancetype)shared;

#pragma mark - Public methods

- (BOOL)validateCardanoAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END

//------------------------------------------//
