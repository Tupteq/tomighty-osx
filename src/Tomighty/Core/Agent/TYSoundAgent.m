//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYSoundAgent.h"
#import "TYTimerContext.h"

@implementation TYSoundAgent
{
    id <TYSoundPlayer> soundPlayer;
    id <TYPreferences> preferences;
}

- (id)initWith:(id <TYSoundPlayer>)aSoundPlayer preferences:(id <TYPreferences>)aPreferences
{
    self = [super self];
    if(self)
    {
        soundPlayer = aSoundPlayer;
        preferences = aPreferences;
    }
    return self;
}

- (void)playSoundsInResponseToEventsFrom:(id <TYEventBus>)eventBus
{
    [eventBus subscribeTo:TIMER_START subscriber:^(id timerContext)
    {
        if([self->preferences getInt:PREF_PLAY_SOUND_WHEN_TIMER_STARTS])
        {
            [self->soundPlayer play:SOUND_TIMER_START];
        }
    }];
    
    [eventBus subscribeTo:TIMER_STOP subscriber:^(id eventData) {
        [self->soundPlayer stopCurrentLoop];
    }];
    
    [eventBus subscribeTo:POMODORO_START subscriber:^(id timerContext)
    {
        [self->soundPlayer stopCurrentLoop];
        if([self->preferences getInt:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO])
        {
            [self->soundPlayer loop:SOUND_TIMER_TICK];
        }
    }];
    
    [eventBus subscribeTo:BREAK_START subscriber:^(id timerContext)
    {
        [self->soundPlayer stopCurrentLoop];
        if([self->preferences getInt:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK])
        {
            [self->soundPlayer loop:SOUND_TIMER_TICK];
        }
    }];
    
    [eventBus subscribeTo:TIMER_GOES_OFF subscriber:^(id timerContext)
    {
        if([self->preferences getInt:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF])
        {
            [self->soundPlayer play:SOUND_TIMER_GOES_OFF];
        }
    }];
}

@end
