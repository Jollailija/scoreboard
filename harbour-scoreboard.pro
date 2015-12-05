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
# Thanks, kimmoli! For future reference: https://github.com/kimmoli/test5-app/blob/master/test5.pro
TEMPLATE = aux

#CONFIG += sailfishapp

#SOURCES += src/harbour-scoreboard.cpp

qml.files = qml/*.qml \
    qml/pages/*.qml

qml.path = /usr/share/test5/qml

desktop.files = harbour-scoreboard.desktop
desktop.path = /usr/share/applications

OTHER_FILES += \
    rpm/harbour-scoreboard.spec \
    rpm/harbour-scoreboard.yaml \
    translations/*.ts \
    harbour-scoreboard.desktop \
    harbour-scoreboard.png \
    qml/harbour-scoreboard.png \
    rpm/harbour-scoreboard.changes \
    qml/pages/harbour-scoreboard.png \
    qml/harbour-scoreboard.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-scoreboard-fi.ts

# Thanks, eson57
TRANSLATIONS += translations/harbour-scoreboard-sv.ts

appicons.path = /usr/share/icons/hicolor/
appicons.files = appicons/*

INSTALLS += appicons qml desktop
