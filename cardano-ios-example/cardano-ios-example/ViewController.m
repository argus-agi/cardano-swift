//
//  ViewController.h
//  cardano-ios-example
//
//  Created by Ivan Manov on 24/11/2018.
//  Copyright © 2018 hellc. All rights reserved.
//
//---------------------------------------------------//

#import "ViewController.h"

//---------------------------------------------------//

#import <cardano_ios/cardano-ios.h>

//---------------------------------------------------//

@interface ViewController ()

@end

//---------------------------------------------------//

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self checkValidationMethods];
}

- (void)checkValidationMethods {
    NSString *addressToValidate = @"Ae2tdPwUPEZ7f7RgToFi4EbUozdBNEYs34kRvSKPc33PUD93QUPT9JmxXwq";
    BOOL valid = [CardanoManager.shared addressesValidateBase58Address:addressToValidate];
    NSLog(@"%@ is valid: %@", addressToValidate, valid ? @"YES" : @"NO");
    
    addressToValidate = @"Ae2tdPwUPEZ7f7RgToFi4EbUozdBNEYs34kRvSKPc33PUD93QUPT9JmxXw1";
    valid = [CardanoManager.shared addressesValidateBase58Address:addressToValidate];
    NSLog(@"%@ is valid: %@", addressToValidate, valid ? @"YES" : @"NO");
}

@end

//---------------------------------------------------//
