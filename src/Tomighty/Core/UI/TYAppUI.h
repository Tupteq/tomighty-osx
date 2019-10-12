//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, TYAppUIStatusIconTextFormat) {
    TYAppUIStatusIconTextFormatNone = 0,
    TYAppUIStatusIconTextFormatMinutes,
    TYAppUIStatusIconTextFormatSeconds
};

@protocol TYAppUI <NSObject>

- (void)switchToIdleState;
- (void)switchToPauseState;
- (void)switchToPomodoroState;
- (void)switchToShortBreakState;
- (void)switchToLongBreakState;
- (void)updateRemainingTime:(int)remainingSeconds orUseLastTime:(BOOL)useLastTime;
- (void)updatePomodoroCount:(int)count;
- (void)setStatusIconTextFormat:(TYAppUIStatusIconTextFormat)textFormat;

@end
