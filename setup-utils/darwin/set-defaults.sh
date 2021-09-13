#!/usr/bin/env bash
# vim: ft=sh softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90

set -euo pipefail

# System Preferences > Keyboard >
defaults write NSGlobalDomain KeyRepeat -int 2

# System Preferences > Keyboard >
defaults write NSGlobalDomain InitialKeyRepeat -int 15


#########################################################################################

# System Preferences > Dock > Size:
defaults write com.apple.dock tilesize -int 20

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool false

# System Preferences > Dock > Size (magnified):
defaults write com.apple.dock largesize -int 40

# System Preferences > Dock > Minimize windows into application icon (make it as a separate item)
defaults write com.apple.dock minimize-to-application -bool false

# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool false

# System Preferences > Dock > Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.5

# System Preferences > Dock > Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0

# System Preferences > Dock > Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

#########################################################################################

# System Preferences > Mission Controll > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

#########################################################################################
#
# I haven't tried tweaking the following things, so just go with my gut :shrug:
#
# System Preferences > Trackpad > Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false

#########################################################################################

# Finder > Preferences > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Show wraning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Show wraning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder > View > As Columns (Doesn't work :cry:)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."





#########################################################################################
#
# TODO TODO TODO
#
# * don't show warning when removing from the Trash bin

# * keep folders on top in windows when sorting by name

# * don't keep recent applications in the dock

# * Keep home directory in the favourites for the Finder

# * Make homedir a default place for new windors in Finder

# StandardViewOptions =         {
#     ColumnViewOptions =             {
#         ArrangeBy = dnam;
#         ColumnShowFolderArrow = 1;
#         ColumnShowIcons = 1;
#         ColumnWidth = 245;
#         FontSize = 12;
#         PreviewDisclosureState = 1;
#         SharedArrangeBy = kipl;
#         ShowIconThumbnails = 1;
#         ShowPreview = 1;
#     };
# };

# * Group by Kind: FXPreferredGroupBy = Kind (CMD+J)

# * System Preferences > General > Show scroll bars > When scrolling
#   defaults write -globalDomain AppleShowScrollBars = WhenScrolling

# * Correct setting of key repeat and mouse movements

# * Show in the Menu Bar (top)
#   - Bluetooth > com.apple.controlcenter > NSStatusItem Visible Bluetooth = 1
#   - Battery percentage >
#   - Hide Spotlight
#   - Clock use 24 hours clock com.apple.menuextra.clock > Show 24 hour = 1
#   - Bluetooth

# * Don't add full stop on double space > NSAutomaticPeriodSubstituationEnabled = 0
# * Show VPN status in the menu bar
# * Stick to grid on the desktop
