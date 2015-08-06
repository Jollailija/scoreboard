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
import QtQuick.LocalStorage 2.0

ApplicationWindow
{
    Item {
        id: scores
        property int home: 0
        property int visitor: 0
    }
    Item {
        id: rounds
        property int home: 0
        property int visitor: 0
    }

    Item {
        id: ui
        property bool score: true
    }

    function resetScores(){
        remorse.execute(qsTr("Resetting scores"), function() {scores.home = 0; scores.visitor = 0}, 3000)
    }
    function resetRounds(){
        remorse.execute(qsTr("Resetting rounds"), function() {rounds.home = 0; rounds.visitor = 0}, 3000)
    }
    function storeScores() {
                var db = LocalStorage.openDatabaseSync("ScoreDB", "1.0", "Score storage", 100);

                db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS storeScores(id INT, home INT, visitor INT)');
                        db.transaction( function(tx) {
                                var result = tx.executeSql('SELECT * from storeScores');
                                if(result.rows.length === 1) {
                                    // Update scores
                                    tx.executeSql('UPDATE storeScores set home=? where id=1', [ scores.home ]);
                                    tx.executeSql('UPDATE storeScores set visitor=? where id=1', [ scores.visitor ]);
                                } else {
                                    // Insert first scores
                                    result = tx.executeSql('INSERT INTO storeScores VALUES (?,?,?)', [1, scores.home, scores.visitor]);
                                }
                        }
                        )
                    }
                )
    }
    function storeRounds() {
                var db = LocalStorage.openDatabaseSync("RoundDB", "1.0", "Round storage", 100);

                db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS storeRounds(id INT, home INT, visitor INT)');
                        db.transaction( function(tx) {
                                var result = tx.executeSql('SELECT * from storeRounds');
                                if(result.rows.length === 1) {
                                    // Update rounds
                                    tx.executeSql('UPDATE storeRounds set home=? where id=1', [ rounds.home ]);
                                    tx.executeSql('UPDATE storeRounds set visitor=? where id=1', [ rounds.visitor ]);
                                } else {
                                    // Insert first rounds
                                    result = tx.executeSql('INSERT INTO storeRounds VALUES (?,?,?)', [1, rounds.home, rounds.visitor]);
                                }
                        }
                        )
                    }
                )
    }
    function getScores() {
                var db = LocalStorage.openDatabaseSync("ScoreDB", "1.0", "Score storage", 100);

                db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS storeScores(id INT, home INT, visitor INT)');
                        db.transaction( function(tx) {
                                var result = tx.executeSql('SELECT * from storeScores');
                                if(result.rows.length === 1) {
                                    // Get scores
                                    var home = result.rows[0].home;
                                    scores.home = home
                                    var visitor = result.rows[0].visitor;
                                    scores.visitor = visitor
                                } else {
                                    // Insert first scores
                                    result = tx.executeSql('INSERT INTO storeScores VALUES (?,?,?)', [1, scores.home, scores.visitor]);
                                }
                        }
                        )
                    }
                )
    }
    function getRounds() {
                var db = LocalStorage.openDatabaseSync("RoundDB", "1.0", "Round storage", 100);

                db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS storeRounds(id INT, home INT, visitor INT)');
                        db.transaction( function(tx) {
                                var result = tx.executeSql('SELECT * from storeRounds');
                                if(result.rows.length === 1) {
                                    // Get scores
                                    var home = result.rows[0].home;
                                    rounds.home = home
                                    var visitor = result.rows[0].visitor;
                                    rounds.visitor = visitor
                                } else {
                                    // Insert first scores
                                    result = tx.executeSql('INSERT INTO storeRounds VALUES (?,?,?)', [1, rounds.home, rounds.visitor]);
                                }
                        }
                        )
                    }
                )
    }

    RemorsePopup {id: remorse}

    Component {
        id: scoreSetPage
        Page {
            id: page
            allowedOrientations: Orientation.All
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
                        text: rounds.home + "-" + rounds.visitor
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
    }

    initialPage: Component {
        Page {
            id: page
            allowedOrientations: Orientation.All
            SilicaFlickable {
                anchors.fill: parent
                contentHeight: header.height
                PullDownMenu {
                    //TESTING RELATED STUFF STARTS
                    /*
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
                    */
                    //TESTING RELATED STUFF ENDS
                    MenuItem {
                        text: qsTr("Saved scores")
                        onClicked: {getScores(); getRounds()}
                    }
                    MenuItem {
                        text: qsTr("Set scores & rounds")
                        onClicked: pageStack.push(scoreSetPage)
                    }
                    MenuItem {
                        text: ui.score ? qsTr("Reset scores") : qsTr("Reset rounds")
                        onClicked: ui.score ? resetScores() : resetRounds()
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: header.bottom
                        anchors.topMargin: 0
                        text: rounds.home + "-" + rounds.visitor
                        color: ui.score ? Theme.secondaryHighlightColor : Theme.highlightColor
                        font.pixelSize: Theme.fontSizeExtraLarge * 2
                        MouseArea {
                            anchors.fill: parent
                            onClicked: ui.score = false //, console.debug("ui score false")
                            enabled: ui.score //because MouseAreas overlap eachother in landskape
                        }
                    }
                    Label {
                        id: scoreboardScores
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: page.isPortrait ? scoreboardRounds.bottom : header.bottom
                        anchors.topMargin: page.isPortrait ? 0 : ((scores.home > 99 | scores.visitor > 99) ? Theme.paddingLarge * 3 : Theme.paddingLarge)
                        text: scores.home + "-" + scores.visitor
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
                            anchors.top: page.isPortrait ? scoreboardScores.bottom : header.bottom
                            anchors.topMargin: page.isPortrait ? (Theme.paddingLarge * 2) : (Theme.paddingLarge * 3)
                            anchors.left: parent.left
                            anchors.leftMargin: page.isPortrait ? (Theme.paddingLarge * 5)  : (Theme.paddingLarge * 1.5)
                            icon.source: "image://theme/icon-m-add"
                            icon.height: 150
                            icon.width: 150
                            onClicked: ui.score ? (scores.home ++, storeScores()) : (rounds.home ++, storeRounds())
                            enabled: ui.score ? scores.home < 999 : rounds.home < 999
                        }
                        IconButton {
                            id: plusVisitor
                            anchors.top: page.isPortrait ? scoreboardScores.bottom : header.bottom
                            anchors.topMargin: page.isPortrait ? (Theme.paddingLarge * 2) : (Theme.paddingLarge * 3)
                            anchors.right: parent.right
                            anchors.rightMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
                            icon.source: "image://theme/icon-m-add"
                            icon.height: 150
                            icon.width: 150
                            onClicked: ui.score ? (scores.visitor ++, storeScores()) : (rounds.visitor ++, storeRounds())
                            enabled: ui.score ? scores.visitor < 999 : rounds.visitor < 999
                        }
                    //}
                    /*Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: Theme.paddingLarge * 5 */
                        IconButton {
                            id: minusHome
                            anchors.top: plusHome.bottom
                            anchors.topMargin: Theme.paddingLarge * 5.5
                            anchors.leftMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
                            anchors.left: parent.left
                            icon.source: "image://theme/icon-m-remove"
                            icon.height: 150
                            icon.width: 150
                            onClicked: ui.score ? (scores.home --, storeScores()) : (rounds.home --, storeRounds())
                            enabled: ui.score ? scores.home > 0 : rounds.home > 0
                        }
                        IconButton {
                            id: minusVisitor
                            anchors.top: plusVisitor.bottom
                            anchors.topMargin: Theme.paddingLarge * 5.5
                            anchors.rightMargin: page.isPortrait ? (Theme.paddingLarge * 5) : (Theme.paddingLarge * 1.5)
                            anchors.right: parent.right
                            icon.source: "image://theme/icon-m-remove"
                            icon.height: 150
                            icon.width: 150
                            onClicked: ui.score ? (scores.visitor --, storeScores()) : (rounds.visitor --, storeRounds())
                            enabled: ui.score ? scores.visitor > 0 : rounds.visitor > 0
                        }
                    //}
                //}
            }
        }
    }
    cover: Component {
        CoverBackground {
            Image {
               id: logo
               source: "harbour-scoreboard.png"
               anchors.horizontalCenter: parent.horizontalCenter
               y: parent.height * 0.15
             }
            Label {
                id: label
                y: parent.height * 0.4
                anchors.horizontalCenter: parent.horizontalCenter
                text: rounds.home + "-" + rounds.visitor
                font.pixelSize: Theme.fontSizeMedium
                visible: (rounds.home > 0 | rounds.visitor > 0)
            }
            Label {
                id: label2
                y: (rounds.home > 0 | rounds.visitor > 0) ? (parent.height * 0.45) : (parent.height * 0.4)
                anchors.horizontalCenter: parent.horizontalCenter
                text: scores.home + "-" + scores.visitor
                font.pixelSize: (scores.home > 99 | scores.visitor > 99) ? Theme.fontSizeExtraLarge * 1.5 : Theme.fontSizeExtraLarge * 2
            }

            CoverActionList {
                id: coverAction

                CoverAction {
                    iconSource: "image://theme/icon-cover-new"
                    onTriggered: {scores.home ++; storeScores()}
                }

                CoverAction {
                    iconSource: "image://theme/icon-cover-new"
                    onTriggered: {scores.visitor ++; storeScores()}
                }
            }
        }
    }
}


