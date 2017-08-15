#import <dlfcn.h>
#import <objc/runtime.h>
#import <substrate.h>

#define NSLog

@interface NSObject ()
+ (id)sharedPanel;
- (NSString *)descriptionOfState:(int)state forSwitchIdentifier:(NSString *)switchIdentifier;
- (int)stateForSwitchIdentifier:(NSString *)switchIdentifier;
- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier;

+ (id)statusUpdateWithString:(id)arg1 reason:(id)arg2;

- (void)section:(id)section publishStatusUpdate:(id)update;

- (UIViewController*)_viewControllerForAncestor;

- (id)delegate;
@end

%hook FCCButtonsScrollView
- (void)showStateForSwitchWithIdentifier:(id)arg1
{
	%orig;
	NSString* nameStatus = [[%c(FSSwitchPanel) sharedPanel] descriptionOfState:[[%c(FSSwitchPanel) sharedPanel] stateForSwitchIdentifier:arg1] forSwitchIdentifier:arg1];
	NSString* titleSw = [[%c(FSSwitchPanel) sharedPanel] titleForSwitchIdentifier:arg1];
	if(nameStatus && titleSw) {
		nameStatus = [titleSw stringByAppendingFormat:@": %@", nameStatus];
	}
	if(!nameStatus && titleSw) {
		nameStatus = titleSw;
	}
	if(nameStatus) {
		id sectionController = [(id)self _viewControllerForAncestor];
		[[sectionController delegate] section:sectionController publishStatusUpdate:[%c(CCUIControlCenterStatusUpdate) statusUpdateWithString:nameStatus reason:nameStatus]];
	}
}
%end

%ctor
{
	dlopen("/Library/MobileSubstrate/DynamicLibraries/FlipControlCenter.dylib", RTLD_LAZY);
}