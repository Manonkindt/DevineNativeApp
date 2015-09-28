// Generated by Apple Swift version 1.2 (swiftlang-602.0.49.6 clang-602.0.49)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import AVFoundation;
@import CoreMedia;
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

/// Completion mode.
///
/// <ul><li><p>Determinate: Terminates the detection after a determinated number of valid windows is received.</p></li><li><p>Indeterminate: Dosn't terminate the detection of heart rate.</p></li></ul>
typedef SWIFT_ENUM(NSInteger, CHCompletionMode) {
  CHCompletionModeDetermined = 0,
  CHCompletionModeIndeterminate = 1,
};


/// Erorr.
///
/// <ul><li><p>Auth: AVAuthorization not granted.</p></li></ul>
typedef SWIFT_ENUM(NSInteger, CHError) {
  CHErrorAuth = 0,
};


/// Status.
///
/// <ul><li><p>Waiting: Waiting for a finger on camera lens.</p></li><li><p>DetectingPulse: Synchronizing to the heart rate pulse.</p></li><li><p>Measurement: Measuring the heart rate frequency.</p></li><li><p>Completed: Measurement completed.</p></li></ul>
typedef SWIFT_ENUM(NSInteger, CHStatus) {
  CHStatusWaiting = 0,
  CHStatusDetectingPulse = 1,
  CHStatusMeasurement = 2,
  CHStatusCompleted = 3,
};

@protocol CoreHeartDelegate;
@class EKGPlotter;
@class AVCaptureOutput;
@class AVCaptureConnection;


/// CoreHeart controller.
SWIFT_CLASS("_TtC9CoreHeart9CoreHeart")
@interface CoreHeart : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

/// Version.
@property (nonatomic) float version;

/// The object that acts as the delegate.
@property (nonatomic) id <CoreHeartDelegate> __nullable delegate;

/// The object that acts as a plotter for the signal.
@property (nonatomic) EKGPlotter * __nullable plotter;

/// Number of frames without the finger on camera lens before to restart the session.
@property (nonatomic) NSInteger numberOfFramesLostBeforeRestart;

/// Number of valid windows required to calculate the BPM.
@property (nonatomic) NSInteger numberOfValidWindows;

/// Completion mode.
@property (nonatomic) enum CHCompletionMode completionMode;

/// Requests access from Capture Device if it's not determined.
@property (nonatomic) BOOL requestAccessForMediaType;

/// Starts the detection of the heart rate.
- (void)start;

/// Stops the current session.
- (void)stop;
- (void)captureOutput:(AVCaptureOutput * __null_unspecified)captureOutput didOutputSampleBuffer:(CMSampleBufferRef __null_unspecified)sampleBuffer fromConnection:(AVCaptureConnection * __null_unspecified)connection;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end



/// Notifies about any changes for CoreHeart.
SWIFT_PROTOCOL("_TtP9CoreHeart17CoreHeartDelegate_")
@protocol CoreHeartDelegate

/// Notifies a window has been received.
///
/// \param bpm Current Beats Per Minute.
///
/// \param progress Percentage of completion.
- (void)receivedPulse:(NSInteger)bpm progress:(double)progress;

/// Notifies the measurement has been completed.
///
/// \param bpm Beats Per Minute
- (void)completed:(NSInteger)bpm;

/// Notifies the status has been changed.
///
/// \param status The status.
- (void)statusDidChange:(enum CHStatus)status;

/// Notifies for error.
///
/// \param err The error type.
- (void)error:(enum CHError)err;
@end

@class UIColor;
@class NSCoder;

SWIFT_CLASS("_TtC9CoreHeart10EKGPlotter")
@interface EKGPlotter : UIView
@property (nonatomic) BOOL drawGrid;
@property (nonatomic) UIColor * __nonnull gridColor;
@property (nonatomic) UIColor * __nonnull plotColor;
@property (nonatomic) BOOL autoClean;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
- (void)clean;
@end

#pragma clang diagnostic pop
