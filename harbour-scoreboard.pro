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
# Thanks, kimmoli!
#TEMPLATE = aux

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
    rpm/harbour-scoreboard.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-scoreboard-fi.ts

# Thanks, eson57
TRANSLATIONS += translations/harbour-scoreboard-sv.ts

DISTFILES += \
    qml/pages/harbour-scoreboard.png \
    qml/pages/About.qml \
    qml/pages/Help.qml \
    qml/pages/MultiplePlayers.qml \
    qml/pages/TTSetScores.qml \
    qml/pages/TTView.qml \
    qml/pages/PulleyMenu.qml \
    qml/harbour-scoreboard.png

