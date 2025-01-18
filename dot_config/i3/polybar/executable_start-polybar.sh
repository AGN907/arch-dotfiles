#!/bin/sh

CONFIG=$HOME/.config/i3/polybar/config.ini

./kill-polybar.sh

polybar left --config=$CONFIG &
polybar center --config=$CONFIG &
polybar right --config=$CONFIG &
