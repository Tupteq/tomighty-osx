//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

@protocol TYStatusMenu <NSObject>

- (void)enableStopTimerItem:(BOOL)enable;
- (void)enablePauseItem:(BOOL)enable hidden:(BOOL)hidden;
- (void)enableResumeItem:(BOOL)enable hidden:(BOOL)hidden;
- (void)enableStartPomodoroItem:(BOOL)enable;
- (void)enableStartShortBreakItem:(BOOL)enable;
- (void)enableStartLongBreakItem:(BOOL)enable;
- (void)enableResetPomodoroCountItem:(BOOL)enable;
- (void)setRemainingTimeText:(NSString *)text;
- (void)setPomodoroCountText:(NSString *)text;

@end
