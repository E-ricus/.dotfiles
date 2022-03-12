#!/bin/sh

# Everything you write here will be executed by the display manager when setting up the login screen in "hybrid" mode.
nvidia-settings --assign CurrentMetaMode="DP-1-0:3840x2160_60 +3840+0 { ForceFullCompositionPipeline = On }"
