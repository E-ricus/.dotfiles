#!/bin/sh

# Everything you write here will be executed by the display manager when setting up the login screen in "nvidia" mode.
# (but before optimus-manager sets up PRIME with xrandr commands).
nvidia-settings --assign CurrentMetaMode="DP-0:3840x2160_60 +0+0 { ForceFullCompositionPipeline = On }"
