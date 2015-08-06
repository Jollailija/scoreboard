# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-scoreboard

CONFIG += sailfishapp

SOURCES += src/harbour-scoreboard.cpp

OTHER_FILES += qml/harbour-scoreboard.qml \
    rpm/harbour-scoreboard.spec \
    rpm/harbour-scoreboard.yaml \
    translations/*.ts \
    harbour-scoreboard.desktop \
    harbour-scoreboard.png \
    qml/harbour-scoreboard.png \
    qml/Help.qml \
    qml/About.qml \
    rpm/harbour-scoreboard.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
# TRANSLATIONS += translations/harbour-scoreboard-de.ts

