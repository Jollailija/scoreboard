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
//import QtQuick.LocalStorage 2.0


SilicaFlickable {

    anchors.fill: parent
    contentHeight: page.height

    RemorsePopup {
        id: remorse
        anchors.top: ttView.top
    }

    function resetScores(){
        remorse.execute(qsTr("Resetting scores"), function() {scores.home = 0; scores.visitor = 0}, 3000)
    }
    function resetRounds(){
        remorse.execute(qsTr("Resetting rounds"), function() {rounds.home = 0; rounds.visitor = 0}, 3000)
    }

    PullDownMenu {
        //TESTING RELATED STUFF STARTS

        MenuItem {
            text: "Portrait"
            onClicked: {
                allowedOrientations = Orientation.Portrait
            }
        }
        MenuItem {
            text: "Landscape"
            onClicked: {
                allowedOrientations = Orientation.Landscape
            }
        }

        //TESTING RELATED STUFF ENDS
        MenuItem {
            text: qsTr("About")
            onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
        }

        MenuItem {
            text: qsTr("Help")
            onClicked: pageStack.push(Qt.resolvedUrl("Help.qml"))
        }
    }

    /* Columns are for noobs ;)
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge * 3*/
    PageHeader {
        id: header
        title: qsTr("Scoreboard")
    }
    Label {
        id: scoreboardRounds
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: header.bottom
            topMargin: 0
        }
        text: ui.swapped
              ? "V " + rounds.visitor + "-" + rounds.home + " H"
              : "H " + rounds.home + "-" + rounds.visitor + " V"
        color: ui.score ? Theme.secondaryHighlightColor : Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraLarge * 2
        MouseArea {
            anchors.fill: parent
            onClicked: ui.score = false //, console.debug("ui score false")
            enabled: ui.score //because MouseAreas overlap eachother in landscape
        }
    }
    Label {
        id: scoreboardScores
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: page.isPortrait ? scoreboardRounds.bottom : header.bottom
            topMargin: page.isPortrait ? 0 : ((scores.home > 99 | scores.visitor > 99) ? Theme.paddingLarge * 3 : Theme.paddingLarge)
        }
        text: ui.swapped
              ? scores.visitor + "-" + scores.home
              : scores.home + "-" + scores.visitor
        color: ui.score ? Theme.highlightColor : Theme.secondaryHighlightColor
        font.pixelSize: page.isPortrait ? ((scores.home > 99 | scores.visitor > 99) ? Theme.fontSizeExtraLarge * 3 : Theme.fontSizeExtraLarge * 4) : ((scores.home > 99 | scores.visitor > 99) ? Theme.fontSizeExtraLarge * 4 : Theme.fontSizeExtraLarge * 6)
        MouseArea {
            anchors.fill: parent
            onClicked: ui.score = true //, console.debug("ui score true")
            enabled: !ui.score //because MouseAreas overlap eachother in landskape
        }
    }
    /*Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge * 5 */
    IconButton {
        id: plusHome
        anchors {
            top: page.isPortrait ? scoreboardScores.bottom : header.bottom
            topMargin: page.isPortrait ? (Theme.paddingLarge * 2) : (Theme.paddingLarge * 3)
            left: parent.left
            leftMargin: page.isPortrait ? (Theme.paddingLarge * 5)  : (Theme.paddingLarge * 1.5)
        }
        icon.source: "image://theme/icon-l-add"
        icon.height: 125
        icon.width: 125
        onClicked: ui.swapped
                   ? ui.score ? (scores.visitor ++, storeScores()) : (rounds.visitor ++, storeRounds())
        : ui.score ? (scores.home ++, storeScores()) : (rounds.home ++, storeRounds())
        enabled: ui.swapped
                 ? ui.score ? scores.visitor < 999 : rounds.visitor < 999
        : ui.score ? scores.home < 999 : rounds.home < 999
    }
    IconButton {
        id: plusVisitor
        anchors {
            top: page.isPortrait ? scoreboardScores.bottom : header.bottom
            topMargin: page.isPortrait ? (Theme.paddingLarge * 2) : (Theme.paddingLarge * 3)
            right: parent.right
            rightMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
        }
        icon.source: "image://theme/icon-l-add"
        icon.height: 125
        icon.width: 125
        onClicked: ui.swapped
                   ? ui.score ? (scores.home ++, storeScores()) : (rounds.home ++, storeRounds())
        : ui.score ? (scores.visitor ++, storeScores()) : (rounds.visitor ++, storeRounds())
        enabled: ui.swapped
                 ? ui.score ? scores.home < 999 : rounds.home < 999
        : ui.score ? scores.visitor < 999 : rounds.visitor < 999

    }
    //}
    /*Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingLarge * 5 */
    IconButton {
        id: minusHome
        anchors {
            top: plusHome.bottom
            topMargin: Theme.paddingLarge * 5.5
            leftMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
            left: parent.left
        }
        icon.source: "image://theme/icon-m-remove"
        icon.height: 150
        icon.width: 150
        onClicked: ui.swapped
                   ? ui.score ? (scores.visitor --, storeScores()) : (rounds.visitor --, storeRounds())
        : ui.score ? (scores.home --, storeScores()) : (rounds.home --, storeRounds())
        enabled: ui.swapped
                 ? ui.score ? scores.visitor > 0 : rounds.visitor > 0
        : ui.score ? scores.home > 0 : rounds.home > 0
    }
    IconButton {
        id: minusVisitor
        anchors {
            top: plusVisitor.bottom
            topMargin: Theme.paddingLarge * 5.5
            rightMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
            right: parent.right
        }
        icon.source: "image://theme/icon-m-remove"
        icon.height: 150
        icon.width: 150
        onClicked: ui.swapped
                   ? ui.score ? (scores.home --, storeScores()) : (rounds.home --, storeRounds())
        : ui.score ? (scores.visitor --, storeScores()) : (rounds.visitor --, storeRounds())
        enabled: ui.swapped
                 ? ui.score ? scores.home > 0 : rounds.home > 0
        : ui.score ? scores.visitor > 0 : rounds.visitor > 0
    }
    //}
    //}
    PushUpMenu {
        MenuItem {
            text: qsTr("Swap")
            onClicked: ui.swapped
                       ? ui.swapped = false
                       : ui.swapped = true
        }
        MenuItem {
            text: qsTr("Saved scores")
            onClicked: {getScores(); getRounds()}
        }
        MenuItem {
            text: qsTr("Set scores & rounds")
            onClicked: pageStack.push(Qt.resolvedUrl("TTSetScores.qml"))
        }
        MenuItem {
            text: ui.score ? qsTr("Reset scores") : qsTr("Reset rounds")
            onClicked: ui.score ? resetScores() : resetRounds()
        }
    }
}

