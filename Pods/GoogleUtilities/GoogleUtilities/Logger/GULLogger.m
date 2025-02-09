// Copyright 2018 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GoogleUtilities/Logger/Public/GoogleUtilities/GULLogger.h"

<<<<<<< HEAD
#include <asl.h>
=======
#import <os/log.h>
>>>>>>> tik_2-NetworkSession

#import "GoogleUtilities/Environment/Public/GoogleUtilities/GULAppEnvironmentUtil.h"
#import "GoogleUtilities/Logger/Public/GoogleUtilities/GULLoggerLevel.h"

<<<<<<< HEAD
/// ASL client facility name used by GULLogger.
const char *kGULLoggerASLClientFacilityName = "com.google.utilities.logger";

static dispatch_once_t sGULLoggerOnceToken;

static aslclient sGULLoggerClient;

=======
static dispatch_once_t sGULLoggerOnceToken;

>>>>>>> tik_2-NetworkSession
static dispatch_queue_t sGULClientQueue;

static BOOL sGULLoggerDebugMode;

static GULLoggerLevel sGULLoggerMaximumLevel;

// Allow clients to register a version to include in the log.
static NSString *sVersion = @"";

<<<<<<< HEAD
static GULLoggerService kGULLoggerLogger = @"[GULLogger]";

=======
NSString *const kGULLogSubsystem = @"com.google.utilities.logger";

static GULLoggerService kGULLoggerLogger = @"[GULLogger]";

static NSMutableDictionary<NSString *, NSMutableDictionary<GULLoggerService, os_log_t> *>
    *sGULServiceLogs;

>>>>>>> tik_2-NetworkSession
#ifdef DEBUG
/// The regex pattern for the message code.
static NSString *const kMessageCodePattern = @"^I-[A-Z]{3}[0-9]{6}$";
static NSRegularExpression *sMessageCodeRegex;
#endif

<<<<<<< HEAD
void GULLoggerInitializeASL(void) {
  dispatch_once(&sGULLoggerOnceToken, ^{
    NSInteger majorOSVersion = [[GULAppEnvironmentUtil systemVersion] integerValue];
    uint32_t aslOptions = ASL_OPT_STDERR;
#if TARGET_OS_SIMULATOR
    // The iOS 11 simulator doesn't need the ASL_OPT_STDERR flag.
    if (majorOSVersion >= 11) {
      aslOptions = 0;
    }
#else
    // Devices running iOS 10 or higher don't need the ASL_OPT_STDERR flag.
    if (majorOSVersion >= 10) {
      aslOptions = 0;
    }
#endif  // TARGET_OS_SIMULATOR

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"  // asl is deprecated
    // Initialize the ASL client handle.
    sGULLoggerClient = asl_open(NULL, kGULLoggerASLClientFacilityName, aslOptions);
    sGULLoggerMaximumLevel = GULLoggerLevelNotice;

    // Set the filter used by system/device log. Initialize in default mode.
    asl_set_filter(sGULLoggerClient, ASL_FILTER_MASK_UPTO(ASL_LEVEL_NOTICE));

    sGULClientQueue = dispatch_queue_create("GULLoggingClientQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(sGULClientQueue,
                              dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
=======
void GULLoggerInitialize(void) {
  dispatch_once(&sGULLoggerOnceToken, ^{
    sGULLoggerMaximumLevel = GULLoggerLevelNotice;
    sGULClientQueue = dispatch_queue_create("GULLoggingClientQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(sGULClientQueue,
                              dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    sGULServiceLogs = [NSMutableDictionary dictionary];
>>>>>>> tik_2-NetworkSession
#ifdef DEBUG
    sMessageCodeRegex = [NSRegularExpression regularExpressionWithPattern:kMessageCodePattern
                                                                  options:0
                                                                    error:NULL];
#endif
  });
}

<<<<<<< HEAD
void GULLoggerEnableSTDERR(void) {
  asl_add_log_file(sGULLoggerClient, STDERR_FILENO);
}

=======
>>>>>>> tik_2-NetworkSession
void GULLoggerForceDebug(void) {
  // We should enable debug mode if we're not running from App Store.
  if (![GULAppEnvironmentUtil isFromAppStore]) {
    sGULLoggerDebugMode = YES;
    GULSetLoggerLevel(GULLoggerLevelDebug);
  }
}

GULLoggerLevel GULGetLoggerLevel(void) {
  return sGULLoggerMaximumLevel;
}

__attribute__((no_sanitize("thread"))) void GULSetLoggerLevel(GULLoggerLevel loggerLevel) {
  if (loggerLevel < GULLoggerLevelMin || loggerLevel > GULLoggerLevelMax) {
<<<<<<< HEAD
    GULLogError(kGULLoggerLogger, NO, @"I-COR000023", @"Invalid logger level, %ld",
                (long)loggerLevel);
    return;
  }
  GULLoggerInitializeASL();
=======
    GULOSLogError(kGULLogSubsystem, kGULLoggerLogger, YES, @"I-COR000023",
                  @"Invalid logger level, %ld", (long)loggerLevel);
    return;
  }
  GULLoggerInitialize();
>>>>>>> tik_2-NetworkSession
  // We should not raise the logger level if we are running from App Store.
  if (loggerLevel >= GULLoggerLevelNotice && [GULAppEnvironmentUtil isFromAppStore]) {
    return;
  }

  sGULLoggerMaximumLevel = loggerLevel;
<<<<<<< HEAD
  dispatch_async(sGULClientQueue, ^{
    asl_set_filter(sGULLoggerClient, ASL_FILTER_MASK_UPTO(loggerLevel));
  });
=======
>>>>>>> tik_2-NetworkSession
}

/**
 * Check if the level is high enough to be loggable.
 */
__attribute__((no_sanitize("thread"))) BOOL GULIsLoggableLevel(GULLoggerLevel loggerLevel) {
<<<<<<< HEAD
  GULLoggerInitializeASL();
=======
  GULLoggerInitialize();
>>>>>>> tik_2-NetworkSession
  if (sGULLoggerDebugMode) {
    return YES;
  }
  return (BOOL)(loggerLevel <= sGULLoggerMaximumLevel);
}

#ifdef DEBUG
void GULResetLogger(void) {
  sGULLoggerOnceToken = 0;
  sGULLoggerDebugMode = NO;
  sGULLoggerMaximumLevel = GULLoggerLevelNotice;
}

<<<<<<< HEAD
aslclient getGULLoggerClient(void) {
  return sGULLoggerClient;
}

=======
>>>>>>> tik_2-NetworkSession
dispatch_queue_t getGULClientQueue(void) {
  return sGULClientQueue;
}

BOOL getGULLoggerDebugMode(void) {
  return sGULLoggerDebugMode;
}
#endif

void GULLoggerRegisterVersion(NSString *version) {
  sVersion = version;
}

<<<<<<< HEAD
void GULLogBasic(GULLoggerLevel level,
                 GULLoggerService service,
                 BOOL forceLog,
                 NSString *messageCode,
                 NSString *message,
                 va_list args_ptr) {
  GULLoggerInitializeASL();
=======
os_log_type_t GULLoggerLevelToOSLogType(GULLoggerLevel level) {
  switch (level) {
    case GULLoggerLevelError:
      return OS_LOG_TYPE_ERROR;
    case GULLoggerLevelWarning:
    case GULLoggerLevelNotice:
      return OS_LOG_TYPE_DEFAULT;
    case GULLoggerLevelInfo:
      return OS_LOG_TYPE_INFO;
    case GULLoggerLevelDebug:
      return OS_LOG_TYPE_DEBUG;
  }
}

void GULOSLogBasic(GULLoggerLevel level,
                   NSString *subsystem,
                   NSString *category,
                   BOOL forceLog,
                   NSString *messageCode,
                   NSString *message,
                   va_list args_ptr) {
  GULLoggerInitialize();
>>>>>>> tik_2-NetworkSession
  if (!(level <= sGULLoggerMaximumLevel || sGULLoggerDebugMode || forceLog)) {
    return;
  }

#ifdef DEBUG
  NSCAssert(messageCode.length == 11, @"Incorrect message code length.");
  NSRange messageCodeRange = NSMakeRange(0, messageCode.length);
  NSUInteger __unused numberOfMatches =
      [sMessageCodeRegex numberOfMatchesInString:messageCode options:0 range:messageCodeRange];
  NSCAssert(numberOfMatches == 1, @"Incorrect message code format.");
#endif
  NSString *logMsg;
  if (args_ptr == NULL) {
    logMsg = message;
  } else {
    logMsg = [[NSString alloc] initWithFormat:message arguments:args_ptr];
  }
<<<<<<< HEAD
  logMsg = [NSString stringWithFormat:@"%@ - %@[%@] %@", sVersion, service, messageCode, logMsg];
  dispatch_async(sGULClientQueue, ^{
    asl_log(sGULLoggerClient, NULL, (int)level, "%s", logMsg.UTF8String);
  });
}
#pragma clang diagnostic pop
=======
  logMsg = [NSString stringWithFormat:@"%@ - %@[%@] %@", sVersion, category, messageCode, logMsg];
  dispatch_async(sGULClientQueue, ^{
    NSMutableDictionary<GULLoggerService, os_log_t> *subsystemLogs = sGULServiceLogs[subsystem];
    if (!subsystemLogs) {
      subsystemLogs = [NSMutableDictionary dictionary];
      sGULServiceLogs[subsystem] = subsystemLogs;
    }

    os_log_t serviceLog = [subsystemLogs objectForKey:subsystem];
    if (!serviceLog) {
      serviceLog = os_log_create(subsystem.UTF8String, category.UTF8String);
      subsystemLogs[category] = serviceLog;
    }

    os_log_with_type(serviceLog, GULLoggerLevelToOSLogType(level), "%{public}@", logMsg);
  });
}
>>>>>>> tik_2-NetworkSession

/**
 * Generates the logging functions using macros.
 *
 * Calling GULLogError({service}, @"I-XYZ000001", @"Configure %@ failed.", @"blah") shows:
 * yyyy-mm-dd hh:mm:ss.SSS sender[PID] <Error> [{service}][I-XYZ000001] Configure blah failed.
 * Calling GULLogDebug({service}, @"I-XYZ000001", @"Configure succeed.") shows:
 * yyyy-mm-dd hh:mm:ss.SSS sender[PID] <Debug> [{service}][I-XYZ000001] Configure succeed.
 */
<<<<<<< HEAD
#define GUL_LOGGING_FUNCTION(level)                                                     \
  void GULLog##level(GULLoggerService service, BOOL force, NSString *messageCode,       \
                     NSString *message, ...) {                                          \
    va_list args_ptr;                                                                   \
    va_start(args_ptr, message);                                                        \
    GULLogBasic(GULLoggerLevel##level, service, force, messageCode, message, args_ptr); \
    va_end(args_ptr);                                                                   \
=======
#define GUL_LOGGING_FUNCTION(level)                                                                \
  void GULOSLog##level(NSString *subsystem, NSString *category, BOOL force, NSString *messageCode, \
                       NSString *message, ...) {                                                   \
    va_list args_ptr;                                                                              \
    va_start(args_ptr, message);                                                                   \
    GULOSLogBasic(GULLoggerLevel##level, subsystem, category, force, messageCode, message,         \
                  args_ptr);                                                                       \
    va_end(args_ptr);                                                                              \
>>>>>>> tik_2-NetworkSession
  }

GUL_LOGGING_FUNCTION(Error)
GUL_LOGGING_FUNCTION(Warning)
GUL_LOGGING_FUNCTION(Notice)
GUL_LOGGING_FUNCTION(Info)
GUL_LOGGING_FUNCTION(Debug)

<<<<<<< HEAD
#undef GUL_MAKE_LOGGER
=======
#undef GUL_LOGGING_FUNCTION
>>>>>>> tik_2-NetworkSession

#pragma mark - GULLoggerWrapper

@implementation GULLoggerWrapper

+ (void)logWithLevel:(GULLoggerLevel)level
<<<<<<< HEAD
=======
           subsystem:(NSString *)subsystem
            category:(GULLoggerService)category
         messageCode:(NSString *)messageCode
             message:(NSString *)message
           arguments:(va_list)args {
  GULOSLogBasic(level, subsystem, category, NO, messageCode, message, args);
}

+ (void)logWithLevel:(GULLoggerLevel)level
>>>>>>> tik_2-NetworkSession
         withService:(GULLoggerService)service
            withCode:(NSString *)messageCode
         withMessage:(NSString *)message
            withArgs:(va_list)args {
<<<<<<< HEAD
  GULLogBasic(level, service, NO, messageCode, message, args);
=======
  GULOSLogBasic(level, kGULLogSubsystem, service, NO, messageCode, message, args);
>>>>>>> tik_2-NetworkSession
}

@end
