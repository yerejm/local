#!/bin/bash
# The shoulders of giants
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

set -o errexit
set -o nounset
set -o pipefail

APPS=

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until complete
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable boot sound effect
sudo nvram SystemAudioVolume=" "

#
# Global Settings
#

#
# Keyboard
#
# Enable key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2

# Shorter delay on starting key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Use Function keys as standard function keysi, i.e. F1 is F1, not dim display
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# No smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# No smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#
# Trackpad/Mouse
#
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 2
defaults write NSGlobalDomain com.apple.mouse.scaling -int 3
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1.7

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Always show scollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Stop spelling autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Expand the open/save dialogs
defaults write NSGlobalDomain NSNavPanelFileLastListModeForOpenModeKey -int 1
defaults write NSGlobalDomain NSNavPanelFileLastListModeForSaveModeKey -int 1
defaults write NSGlobalDomain NSNavPanelFileListModeForOpenMode2 -int 1
defaults write NSGlobalDomain NSNavPanelFileListModeForSaveMode2 -int 1
defaults write NSGlobalDomain NavPanelFileListModeForOpenMode -int 1
defaults write NSGlobalDomain NavPanelFileListModeForSaveMode -int 1

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

#
# Printing
#
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#
# Universal Access
#
# Disable transparency (e.g. in the menu bar)
defaults write com.apple.universalaccess reduceTransparency -bool true

#
# Trackpad
#
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0

#
# Dock
#
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "right"
APPS+=" Dock"

#
# Finder
#
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show ~/Library
chflags nohidden ~/Library
APPS+=" Finder"

#
# Safari
#
# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Do not save any personal data
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false

# Ignore pushy sites
defaults write com.apple.Safari CanPromptForPushNotifications -bool false

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Open on blank page always (do not show Top Sites)
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari NewWindowBehavior -int 1

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Assume a UTF-8 world
defaults write com.apple.Safari WebKitDefaultTextEncodingName -string "utf-8"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DefaultTextEncodingName -string "utf-8"

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
APPS+=" Safari"

#
# Mail
#
defaults write com.apple.mail HorizontalViewerLayout -bool false
defaults write com.apple.mail PlayMailSounds -bool false
defaults write com.apple.mail PreferPlainText -bool true
defaults write com.apple.mail SendFormat -string "Plain"
defaults write com.apple.mail SpellCheckingBehavior -string "InlineSpellCheckingEnabled"
defaults write com.apple.mail RichMessageList -bool false
defaults write com.apple.mail DisableURLLoading -bool true
defaults write com.apple.mail AddressDisplayMode -int 3
defaults write com.apple.mail AlwaysIncludeOriginalMessage -bool true
defaults write com.apple.mail ThreadingDefault -int 0

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "no"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "NO"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
APPS+=" Mail"

#
# Spotlight
#
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1 || true
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

#
# Clock
#
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  h:mm:ss a"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

#
# Screensaver
#
defaults write com.apple.screensaver askForPassword -int 1

#
# Screenshots
#
# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

#
# Time Machine
#
# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

#
# iTerm2
#
# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in ${APPS}; do
  killall "${app}" > /dev/null 2>&1 || true
done
