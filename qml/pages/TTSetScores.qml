/*
  Copyright (C) 2015 jollailija
  Contact: jollailija <jollailija@gmail.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The names of the contributors may not be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        VerticalScrollDecorator {}
        anchors.fill: parent
        contentHeight: header.height + scoreboardRounds.height +scoreboardScores.height + homeScore.height + visitorScore.height + homeRounds.height + visitorRounds.height + hint.height
        PageHeader {
            id: header
            title: qsTr("Set scores")
        }
        Label {
            id: scoreboardRounds
            anchors.top: header.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "H " + rounds.home + "-" + rounds.visitor + " V"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeExtraLarge * 2
        }
        Label {
            id: scoreboardScores
            anchors.top: scoreboardRounds.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: scores.home + "-" + scores.visitor
            color: Theme.secondaryHighlightColor
            font.pixelSize: (scores.home > 99 | scores.visitor > 99) ? Theme.fontSizeExtraLarge * 3 : Theme.fontSizeExtraLarge * 4
        }
        TextField {
            id: homeScore
            anchors.top: scoreboardScores.bottom
            anchors.left: parent.left
            anchors.topMargin: Theme.paddingLarge
            width: parent.width * 0.5 //anchors.horizontalCenter: parent.horizontalCenter
            validator: RegExpValidator { regExp: /^[0-9]{1,3}$/ }
            inputMethodHints: Qt.ImhDigitsOnly
            label: qsTr("Home score")
            placeholderText: qsTr("Set home score")
            focus: false
            EnterKey.onClicked: {scores.home = homeScore.text; visitorScore.focus = true; label = qsTr("Home score set."); storeScores()}

        }
        TextField {
            id: visitorScore
            anchors.top: scoreboardScores.bottom
            anchors.right: parent.right
            anchors.topMargin: Theme.paddingLarge
            width: parent.width * 0.5 //anchors.horizontalCenter: parent.horizontalCenter
            validator: RegExpValidator { regExp: /^[0-9]{1,3}$/ }
            inputMethodHints: Qt.ImhDigitsOnly
            label: qsTr("Visitor score")
            placeholderText: qsTr("Set visitor score")
            focus: false
            EnterKey.onClicked: {scores.visitor = visitorScore.text; parent.focus = true; label = qsTr("Visitor score set."); storeScores()}

        }
        TextField {
            id: homeRounds
            anchors.top: homeScore.bottom
            anchors.left: parent.left
            anchors.topMargin: Theme.paddingLarge
            width: parent.width * 0.5 //anchors.horizontalCenter: parent.horizontalCenter
            validator: RegExpValidator { regExp: /^[0-9]{1,3}$/ }
            inputMethodHints: Qt.ImhDigitsOnly
            label: qsTr("Home rounds")
            placeholderText: qsTr("Set home rounds")
            focus: false
            EnterKey.onClicked: {rounds.home = homeRounds.text; visitorRounds.focus = true; label = qsTr("Home rounds set."); storeRounds()}

        }
        TextField {
            id: visitorRounds
            anchors.top: visitorScore.bottom
            anchors.right: parent.right
            anchors.topMargin: Theme.paddingLarge
            width: parent.width * 0.5 //anchors.horizontalCenter: parent.horizontalCenter
            validator: RegExpValidator { regExp: /^[0-9]{1,3}$/ }
            inputMethodHints: Qt.ImhDigitsOnly
            label: qsTr("Visitor rounds")
            placeholderText: qsTr("Set visitor rounds")
            focus: false
            EnterKey.onClicked: {rounds.visitor = visitorRounds.text; parent.focus = true; label = qsTr("Visitor rounds set."); storeRounds()}

        }
        Label {
            id: hint
            anchors.top: visitorRounds.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Press enter to save")
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeMedium
        }
    }
}

