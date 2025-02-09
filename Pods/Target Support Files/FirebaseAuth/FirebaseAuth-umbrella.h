#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

<<<<<<< HEAD
#import "FIRActionCodeSettings.h"
#import "FIRAdditionalUserInfo.h"
#import "FIRAuth.h"
#import "FIRAuthAPNSTokenType.h"
#import "FIRAuthCredential.h"
#import "FIRAuthDataResult.h"
#import "FIRAuthErrors.h"
#import "FIRAuthSettings.h"
#import "FIRAuthTokenResult.h"
#import "FIRAuthUIDelegate.h"
=======
#import "FIRAuth.h"
#import "FIRAuthErrors.h"
>>>>>>> tik_2-NetworkSession
#import "FirebaseAuth.h"
#import "FIREmailAuthProvider.h"
#import "FIRFacebookAuthProvider.h"
#import "FIRFederatedAuthProvider.h"
#import "FIRGameCenterAuthProvider.h"
#import "FIRGitHubAuthProvider.h"
#import "FIRGoogleAuthProvider.h"
#import "FIRMultiFactor.h"
<<<<<<< HEAD
#import "FIRMultiFactorAssertion.h"
#import "FIRMultiFactorInfo.h"
#import "FIRMultiFactorResolver.h"
#import "FIRMultiFactorSession.h"
#import "FIROAuthCredential.h"
#import "FIROAuthProvider.h"
#import "FIRPhoneAuthCredential.h"
#import "FIRPhoneAuthProvider.h"
#import "FIRPhoneMultiFactorAssertion.h"
#import "FIRPhoneMultiFactorGenerator.h"
#import "FIRPhoneMultiFactorInfo.h"
#import "FIRTOTPMultiFactorAssertion.h"
#import "FIRTOTPMultiFactorGenerator.h"
#import "FIRTOTPSecret.h"
#import "FIRTwitterAuthProvider.h"
#import "FIRUser.h"
#import "FIRUserInfo.h"
#import "FIRUserMetadata.h"
=======
#import "FIRPhoneAuthProvider.h"
#import "FIRRecaptchaBridge.h"
#import "FIRTwitterAuthProvider.h"
#import "FIRUser.h"
>>>>>>> tik_2-NetworkSession

FOUNDATION_EXPORT double FirebaseAuthVersionNumber;
FOUNDATION_EXPORT const unsigned char FirebaseAuthVersionString[];

