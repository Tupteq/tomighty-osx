//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYDefaultAppUI.h"

@implementation TYDefaultAppUI
{
    id <TYStatusMenu> statusMenu;
    id <TYStatusIcon> statusIcon;

    int lastKnownTime;
}

- (id)initWith:(id <TYStatusMenu>)aStatusMenu statusIcon:(id<TYStatusIcon>)aStatusIcon
{
    self = [super init];
    if(self)
    {
        statusMenu = aStatusMenu;
        statusIcon = aStatusIcon;
    }
    return self;
}

- (void)switchToIdleState
{
    [statusMenu enableStopTimerItem:false];
    [statusMenu enablePauseItem:false hidden:false];
    [statusMenu enableResumeItem:false hidden:true];
    [statusMenu enableStartPomodoroItem:true];
    [statusMenu enableStartShortBreakItem:true];
    [statusMenu enableStartLongBreakItem:true];
    [statusIcon changeIcon:ICON_STATUS_IDLE];
    [self updateRemainingTime:0 orUseLastTime:false];
}

- (void)switchToPauseState
{
    [statusMenu enablePauseItem:false hidden:true];
    [statusMenu enableResumeItem:true hidden:false];
    [statusIcon changeIcon:ICON_STATUS_PAUSE];
}

- (void)switchToPomodoroState
{
    [statusMenu enableStopTimerItem:true];
    [statusMenu enablePauseItem:true hidden:false];
    [statusMenu enableResumeItem:false hidden:true];
    [statusMenu enableStartPomodoroItem:false];
    [statusMenu enableStartShortBreakItem:true];
    [statusMenu enableStartLongBreakItem:true];
    [statusIcon changeIcon:ICON_STATUS_POMODORO];
}

- (void)switchToShortBreakState
{
    [statusMenu enableStopTimerItem:true];
    [statusMenu enablePauseItem:true hidden:false];
    [statusMenu enableResumeItem:false hidden:true];
    [statusMenu enableStartPomodoroItem:true];
    [statusMenu enableStartShortBreakItem:false];
    [statusMenu enableStartLongBreakItem:true];
    [statusIcon changeIcon:ICON_STATUS_SHORT_BREAK];
}

- (void)switchToLongBreakState
{
    [statusMenu enableStopTimerItem:true];
    [statusMenu enablePauseItem:true hidden:false];
    [statusMenu enableResumeItem:false hidden:true];
    [statusMenu enableStartPomodoroItem:true];
    [statusMenu enableStartShortBreakItem:true];
    [statusMenu enableStartLongBreakItem:false];
    [statusIcon changeIcon:ICON_STATUS_LONG_BREAK];
}

- (void)updateRemainingTime:(int)remainingSeconds orUseLastTime:(BOOL)useLastTime;
{
    if (useLastTime) {
        remainingSeconds = lastKnownTime;
    } else {
        lastKnownTime = remainingSeconds;
    }

    int minutes = remainingSeconds / 60;
    int seconds = remainingSeconds % 60;
    
    NSString *text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];

    [statusMenu setRemainingTimeText:text];

    TYAppUIStatusIconTextFormat timeFormat = self.statusIconTextFormat;
    if (timeFormat == TYAppUIStatusIconTextFormatNone) {
        [statusIcon setStatusText:@""];
    } else if (remainingSeconds <= 0){
        [statusIcon setStatusText:@" Stopped"];
    } else {
        if (timeFormat == TYAppUIStatusIconTextFormatMinutes) {
            if(minutes < 1){
                text = [NSString stringWithFormat:@" %02d s", seconds];
            } else {
                text = [NSString stringWithFormat:@" %d m", minutes + (seconds > 0 ? 1 : 0)];
            }
        } else if (timeFormat == TYAppUIStatusIconTextFormatSeconds) {
            text = [NSString stringWithFormat:@" %02d:%02d", minutes, seconds];
        }
        [statusIcon setStatusText:text];
    }
}

- (void)updatePomodoroCount:(int)count
{
    BOOL isPlural = count > 1;
    
    NSString *text = count > 0 ?
        [NSString stringWithFormat:@"%d pomodoro%@", count, isPlural ? @"s" : @""]
        : @"No pomodoros";

    [statusMenu setPomodoroCountText:text];
    [statusMenu enableResetPomodoroCountItem:count > 0];
}

- (void)setStatusIconTextFormat:(TYAppUIStatusIconTextFormat)statusIconTextFormat {
    if (_statusIconTextFormat != statusIconTextFormat) {
        _statusIconTextFormat = statusIconTextFormat;
        [self updateRemainingTime:0 orUseLastTime:true];
    }
}

@end
