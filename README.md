# cardano-ios

## Example

To run the example project, clone the repo, and run `cardano-ios-example` or `cardano-ios-example-swift` target of the workspace.

### Usage (Swift)

Create a bridging header file, and add the cardano-ios framework dependency. Provide bridging header file location in `Project's build settings` -> `Swift Compiler - General` -> `Objective-C Bridging Header` field.

```ObjectiveC
#import <cardano_ios/cardano-ios.h>
```
```swift
var entropy: [UInt8] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
let alias = "Test Wallet"

let wallet: OpaquePointer =
CardanoManager.shared().wallet(withEntropy: Data(bytes: &entropy, count: entropy.count),
andPassword: "abc")
        
let account: OpaquePointer =
CardanoManager.shared().walletCreateAccount(for: wallet, withAlias: alias, accountIndex: 0)
        
let addressString =
CardanoManager.shared().walletGenerateAddress(for: account, internal: 0, from: 0, numIndices: 1)

let valid =
CardanoManager.shared().addressesValidateBase58Address(addressString)
print("\(addressString) is valid: \(valid ? "YES" : "NO")")
// Expect : Ae2tdPwUPEZFvFJcJSyoF3ReaYh67P4W8dkroJwUoeT4yAEY118WPDh5e4G is valid: YES
```

### Usage (ObjC)

```ObjectiveC
#import <cardano_ios/cardano-ios.h>
```
```ObjectiveC
uint8_t entropy[16] = { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 };
NSString* alias = @"Test Wallet";

CardanoWallet *wallet = [CardanoManager.shared
walletWithEntropy:[NSData dataWithBytes:entropy length:sizeof(entropy)]
andPassword:@"abc"];

CardanoAccount *account = [CardanoManager.shared
walletCreateAccountForWallet:wallet
withAlias:alias
accountIndex:0];

NSString *addressString = [CardanoManager.shared
walletGenerateAddressForAccount:account
internal:0
fromIndex:0
numIndices:1];

BOOL valid = [CardanoManager.shared addressesValidateBase58Address:addressString];
NSLog(@"%@ is valid: %@", addressString, valid ? @"YES" : @"NO");
// Expect : Ae2tdPwUPEZFvFJcJSyoF3ReaYh67P4W8dkroJwUoeT4yAEY118WPDh5e4G is valid: YES
```


## License

cardano-ios is available under the MIT license. See the LICENSE file for more info.
