#!/bin/bash
# lv8pv <lv8pv@protonmail.com>
# http://github.com/lv8pv/alarm.git
# ---------------------------------------------------------------------------
# Description:
#   Let you run a simple alarm timer in terminal.
# Dependencies
#   The script need access to mplayer and sleep. The Linux sleep command is
#   normally part of all Linux distros.
# Credits:
#   The script is distributed with a beep1.mp3 file created by Joseph SARDIN
#   https://josephsardin.fr/ The file is downloaded from:
#   https://bigsoundbank.com/sound-0035-electronic-alarm-buzzer-1.html
#
#
# START CONFIG
# ----------------------------------------------------------------------------
# Run the alarm in background
#   (nice if you don't want the script to occupy your terminal)
BACKGROUND=1

# Default sleep time before alarm sound plays.
# Use - N[smhd] - (seconds, minutes, hours, days)
# See `info sleep` for more
DEFAULT_S=10s

# The default playing length of the alarm sound in seconds. It is passed to
# mplayers -endpos flag. The default alarm sound `beep1.mp3` length is 21
# seconds and that then decides the max length
DEFAULT_P=4

# Name of audiofile to play as the alarm sound
AUDIOFILE=beep1.mp3

# The script look for the alarm audio file in the following locations:
# /home/user/audio/beep1.mp3 or next to the script file in ./audio/beep1.mp3
AUDIO_FILE_PATH="$HOME"/audio
# ----------------------------------------------------------------------------
# END CONFIG


if [ "$1" == "-h" ]; then
  cat <<EOF
  A simple terminal alarm clock
  It uses sleep and mplayer to play a audio file at given delay, if default
  configuration is used

  USAGE:  $0 [SLEEP][smhd] [ALARM-LENGHT] | [-h]
          $0
          $0 -h

  OPTIONS:
      [SLEEP][smhd]
          Is the alarm timer. It is a "Number+TimeUnit" combination and the
          value passed to sleep See "info sleep"
          2s  = 2 seconds
          2m  = 2 minutes
          2h  = 2 hours
          1d  = 1 day

          NOTE: The Linux sleep command can accept more then one argument and
          will sum the arguments into one value, but this script only accept ONE
          argument for [SLEEP]

      [ALARM-LENGHT]
          The lenght of the alarm played. (max 25seconds) It is a number value
          in seconds and is passed to 'mplayer's -endpos' flag

      [-h] Prints this help text

  DEFAULTS
      If No arguments is given, the script uses default values configured in
      the script. You can change those to your prefered values
EOF
exit 1
fi

# Check to see that we have the Linux sleep command
if ! command -v sleep &> /dev/null
then
    echo "The sleep command could not be found"
    exit 1
fi

# Check to see that we can run mplayer
if ! command -v mplayer &> /dev/null
then
    echo "Can't find Mplayer. Mplayer is used to play the alarm sound"
    exit 1
fi

mp3file=$AUDIO_FILE_PATH/$AUDIOFILE
# Check to see that the alarm file exists in the configured path
if [ ! -f $mp3file ]; then
  # If not, lets see if it exsists relative to the script location
  path=$( dirname -- "$( readlink -f -- "$0"; )"; )/audio/$AUDIOFILE
  if [ ! -f $path ]; then
    echo "Can't find the alarm file : $path"
    exit 1
  else
    mp3file=$path
  fi
fi

sleeptime=${1-$DEFAULT_S}
playtime=${2-$DEFAULT_P}

# Check to see if we should run the script in the background with `disown`
if [ $BACKGROUND == 1 ]; then
  echo Playing $mp3file in $sleeptime for $playtime sec BACKGROUND = $BACKGROUND
  sleep $sleeptime && mplayer -endpos $playtime $mp3file &>/dev/null & disown
else
  echo Playing $mp3file in $sleeptime for $playtime sec BACKGROUND = $BACKGROUND
  echo "You can run the script in background by editing the script and changing:"
  echo "BACKGROUND=1"
  echo ""
  sleep $sleeptime && mplayer -endpos $playtime $mp3file
fi
