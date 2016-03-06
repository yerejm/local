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
defaults write "Apple Global Domain" AppleActionOnDoubleClick -string "None"
defaults write "Apple Global Domain" AppleInterfaceStyle -string "Dark"
defaults write "Apple Global Domain" AppleShowAllExtensions -bool true
defaults write "Apple Global Domain" AppleShowScrollBars -string "Always"
defaults write "Apple Global Domain" ContextMenuGesture -int 1
# No smart dashes
defaults write "Apple Global Domain" NSAutomaticDashSubstitutionEnabled -bool false
# No smart quotes
defaults write "Apple Global Domain" NSAutomaticQuoteSubstitutionEnabled -bool false
# No spelling autocorrect
defaults write "Apple Global Domain" NSAutomaticSpellingCorrectionEnabled -bool false
defaults write "Apple Global Domain" WebAutomaticSpellingCorrectionEnabled -bool false
# Use Function keys as standard function keysi, i.e. F1 is F1, not dim display
defaults write "Apple Global Domain" com.apple.keyboard.fnState -bool true
# When changing volume, give audio feedback
defaults write "Apple Global Domain" com.apple.sound.beep.feedback -bool true
# Disable "natural" scroll
defaults write "Apple Global Domain" com.apple.swipescrolldirection -bool false
defaults write "Apple Global Domain" com.apple.trackpad.scaling -int 2

# Expand the open/save dialogs
defaults write "Apple Global Domain" NSNavPanelFileLastListModeForOpenModeKey -bool true
defaults write "Apple Global Domain" NSNavPanelFileListModeForOpenMode2 -bool true
defaults write "Apple Global Domain" NavPanelFileListModeForOpenMode -bool true

defaults write "Apple Global Domain" NSNavPanelFileLastListModeForSaveModeKey -bool true
defaults write "Apple Global Domain" NSNavPanelFileListModeForSaveMode2 -bool true
defaults write "Apple Global Domain" NavPanelFileListModeForSaveMode -bool true

# Expand save panel by default
defaults write "Apple Global Domain" NSNavPanelExpandedStateForSaveMode -bool true
defaults write "Apple Global Domain" NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write "Apple Global Domain" PMPrintingExpandedStateForPrint -bool true
defaults write "Apple Global Domain" PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write "Apple Global Domain" NSDocumentSaveNewDocumentsToCloud -bool false

#
# LaunchServices
#
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

#
# Trackpad
#
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0

#
# Menubar
#
PLISTBUDDY=/usr/libexec/plistbuddy
PLIST=$HOME/Library/Preferences/com.apple.systemuiserver.plist
$PLISTBUDDY -c "add :menuExtras:0 string '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'" $PLIST
$PLISTBUDDY -c "add :menuExtras:0 string '/System/Library/CoreServices/Menu Extras/TimeMachine.menu'" $PLIST
$PLISTBUDDY -c "add :menuExtras:0 string '/System/Library/CoreServices/Menu Extras/Volume.menu'" $PLIST

#
# Dock
#
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock orientation -string "right"
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
APPS+=" Dock"

#
# Lookup
#
defaults write com.apple.lookup.lookupEnabled suggestionsEnabled -bool false

#
# Clock
#
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  h:mm:ss a"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

#
# Dictation
#
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMUseOnlyOfflineDictation -bool true

#
# Universal Access
#
# Disable transparency (e.g. in the menu bar)
defaults write com.apple.universalaccess reduceTransparency -bool true

#
# Finder
#
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder FinderSpawnTab -bool false
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/${HOME}"
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Don't create .DS_Store on a network share
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool false

# Show ~/Library
chflags nohidden ~/Library
APPS+=" Finder"

#
# Safari
#
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
defaults write com.apple.Safari AlwaysShowFavoritesBarInFullScreen -bool false
# Do not save any personal data
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari DownloadsClearingPolicy -int 1
# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"
# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
# Open on blank page always (do not show Top Sites)
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari NewWindowBehavior -int 1
defaults write com.apple.Safari PreloadTopHit -bool false
# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# Enable the Web Inspector in Safari
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# Ignore pushy sites
defaults write com.apple.Safari CanPromptForPushNotifications -bool false
# Assume a UTF-8 world
defaults write com.apple.Safari WebKitDefaultTextEncodingName -string "utf-8"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DefaultTextEncodingName -string "utf-8"
# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

APPS+=" Safari"

#
# Printing
#
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

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

###############################################################################
# Kill affected applications                                                  #
###############################################################################
killall cfprefsd
for app in ${APPS}; do
  killall "${app}" > /dev/null 2>&1 || true
done

# https://fix-macosx.com
if [ ! -d fix-macosx ]; then
  git clone --depth 1 https://github.com/fix-macosx/fix-macosx fix-macosx
  ( cd fix-macosx && python fix-macosx.py ) && rm -rf fix-macosx
fi

