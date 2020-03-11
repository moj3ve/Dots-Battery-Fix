@interface NSObject (SafeKVC)
- (id)safeValueForKey:(NSString *)key;
- (void)safelySetValue:(id)obj forKey:(NSString *)key;
@end

@interface SBUIBiometricResource : NSObject
@end

@implementation NSObject (SafeKVC)

- (id)safeValueForKey:(NSString *)key {
    @try {
        return [self valueForKey:key];
    } @catch (NSException *e) {
        return nil;
    }
}

- (void)safelySetValue:(id)val forKey:(NSString *)key {
    @try {
        return [self setValue:val forKey:key];
    } @catch (NSException *e) {}
}

@end

@interface HaloController : NSObject
@property(nonatomic, retain) UIWindow *window;
+ (instancetype)sharedInstance;
@end

UIWindow *window;

%hook SBUIBiometricResource
- (void)noteScreenWillTurnOn {
 
    window = [[%c(HaloController) sharedInstance] window];

   if (window.hidden)  { // Unfortunately if the window was showing but then became hidden this will not update until the screen turns off again 
        // NSLog(@"The dots are not showing!");
        %orig; // If the original function is called - then the Face ID scanner will keep checking again
    }

    else  {      
        [self safelySetValue:@NO forKey:@"_isPresenceDetectionAllowed"]; // If the Dots view is active, disable Face ID detecting faces
        // NSLog(@"The dots are showing!");
    }

    return;
}
%end