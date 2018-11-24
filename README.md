# cardano-ios

[![CI Status](https://travis-ci.org/hellc/cardano-ios.svg?branch=master)](https://travis-ci.org/hellc/cardano-ios)

## Example

To run the example project, clone the repo, and run `cardano-ios-example` target of the workspace.

## Usage
```ObjectiveC
#import <cardano_ios/cardano-ios.h>
```
```ObjectiveC
NSString *addressToValidate = @"Ae2tdPwUPEZ7f7RgToFi4EbUozdBNEYs34kRvSKPc33PUD93QUPT9JmxXwq";
BOOL valid = [CardanoManager.shared addressesValidateBase58Address:addressToValidate];
NSLog(@"%@ is valid: %@", addressToValidate, valid ? @"YES" : @"NO"); //Expect: YES

addressToValidate = @"Ae2tdPwUPEZ7f7RgToFi4EbUozdBNEYs34kRvSKPc33PUD93QUPT9JmxXw1";
valid = [CardanoManager.shared addressesValidateBase58Address:addressToValidate];
NSLog(@"%@ is valid: %@", addressToValidate, valid ? @"YES" : @"NO"); //Expect: NO (last symbol changed)
```


## License

cardano-ios is available under the MIT license. See the LICENSE file for more info.
