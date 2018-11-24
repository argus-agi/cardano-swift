# cardano-ios

## Example

To run the example project, clone the repo, and run `cardano-ios-example` target of the workspace.

### Usage

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

[CardanoManager.shared walletDeleteAccount:account];
[CardanoManager.shared walletDelete:wallet];
```


## License

cardano-ios is available under the MIT license. See the LICENSE file for more info.
