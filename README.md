# alarm.sh
*A simple Linux terminal alarm clock written in bash.*

## Introduction
Every time I make my self a cup of Tea, while sitting at the PC. I end up with a
full cup of Tea that is too strong and ice cold.

More then once have I swore at my **self** and *Slackware*, for not shipping
with a neat little terminal alarm clock I can start and remind me to take the
**DAMN** Tea-bag out of the cup, **before** it turns into cold grout.

Finally I caved in and created my own little app to serve the purpose.

## Credits
This script ships with an MP3 file in `./audio/beep1.mp3` for more and detailed
info look [here](./audio/BEEP1-CREDITS.md) Thank you to [Joseph SARDIN][1] for
sharing his audio file.

## Installing
This is very simple. Go to your terminal and run:
```git
git clone https://github.com/lv8pv/alarm.git
```

This creates a folder named `alarm` where you ran the git clone command. And
that's it. `cd` into the alarm folder and run `./alarm.sh` This will run an
alarm at the default settings (alarm in 10 seconds lasting 4 seconds) You can
change the defaults by editing the alarm.sh file and change the config between
the **START CONFIG** and **END CONFIG** section.

> [!NOTE]
> **Before** running *any* scripts you download from the internet. It's a good
> idea to take a look at the code, in case someone with bad intention plan to do
> nasty stuff. If the script is too complicated to understand, consider if it's
> worth running, or have someone help review the scripts.

## Configuring
There is nothing you **MUST** configure, but you might want to change the
default configuration. Or perhaps if you move the script to a different location
or you want one of your own audio file played as the alarm sound.

There are only 5 `variables` you can configure.

***BACKGROUND***
> This deicide if the script run the alarm in the background, or not. Running it
> in the background is nice when you don't want the script to occupy the terminal.
> ```bash
> BACKGROUND=1
> ```

***DEFAULT_S***
> The first argument to the script is how long until the alarm sound is played.
> 
> If the script is run without any arguments, this is the default time before the
> timer play the alarm sound. Use: s = seconds, m = minutes, h = hours, d = days.
> ```bash
> DEFAULT_S=10s
> ```

***DEFAULT_P***
> The second argument to the script, is how long the alarm sound should play. 
> 
> If the script is run without any arguments, this is the default length of the
> alarm sound in seconds. It uses the `mplayer -endpos` flag to decide how much of
> the audio file it will play.
> ```bash
> DEFAULT_P=4
> ```

***AUDIOFILE***
> This is the default audio file shipped with the script. You can change this to
> any of your own audio files.
> ```bash
> AUDIOFILE=beep1.mp3
> ```

***AUDIO_FILE_PATH***
> The path to the audio file. By default `alarm.sh` looks for the default file
> `beep1.mp3` in two locations. `/home/user/audio` or next to the script in the
> folder `./audio` You can change this to any location you prefer.
> ```bash
> AUDIO_FILE_PATH="$HOME"/audio
> ```

## Usage
With no arguments: This will create an alarm with the default settings
```bash
./alarm.sh
```

With arguments: This example will create an alarm in 2 minutes playing the sound
for 10 seconds
```bash
./alarmsh 2m 10
```

Or two ways to create an alarm in 1 hour, sound lasting 5 seconds
```bash
./alarm.sh 1h 5
./alarm.sh 60s 5
```

For for help:
```bash
./alarm.sh -h
```

[1]: https://josephsardin.fr

<!-- vim: ts=2:sts=2:sw=2:tw=80:cc=80:spell et
-->
