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
import "pages"

ApplicationWindow
{
    id: mainWindow
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

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
        property bool swapped: false
        property int activeView: 3
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

    initialPage: ui.activeView === 1 // future proof?
                 ? ttView
                 : ui.activeView === 2
                   ? mpView
                   : warning

    Component {
        id: ttView
        TTView {}
    }

    Component {
        id: mpView
        MultiplePlayers {}
    }


    Component {
        id: warning
        Page {

            SilicaFlickable {
                anchors.fill: parent
                contentHeight: header.height + text.height + Theme.paddingLarge
                contentWidth: parent.width
                PullDownMenu {
                    MenuItem {
                        text: qsTr("Open the app")
                        onClicked: {pageStack.replace(Qt.resolvedUrl("pages/TTView.qml")); ui.activeView = 1}
                    }
                }

                PageHeader {
                    id: header
                    title: qsTr("Warning!")
                }
                Text {
                    id: text
                    anchors {
                        top: header.top
                        left: parent.left
                        right: parent.right
                        leftMargin: Theme.paddingLarge
                        rightMargin: Theme.paddingLarge
                        topMargin: Theme.paddingLarge * 5
                    }
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: Theme.primaryColor
                    textFormat: Text.StyledText
                    text: "You are using an experimental development build of Scoreboard. Don't worry, it won't bite you. However, some things might not work or are under development. Please bear this in mind.

<h2>Open the app from main PullDownMenu if you want to proceed.</h2>

You can see the changelog by clicking the version number at the about page.
"
                }
            }


        }
    }



    cover: ui.activeView === 1 // future proof?
           ? ttCover
           : undefined

    Component {

        id: ttCover // Cover for two teams mode

        CoverBackground {
            anchors.fill: parent

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
                text: (rounds.home > 0 | rounds.visitor > 0)
                      ? (ui.swapped
                         ? "V " + rounds.visitor + "-" + rounds.home + " H"
                         : "H " + rounds.home + "-" + rounds.visitor + " V")
                      : (ui.swapped
                         ? "V " + "-" + " H"
                         : "H " + "-" + " W")
                font.pixelSize: Theme.fontSizeMedium
            }
            Label {
                id: label2
                y: parent.height * 0.45
                anchors.horizontalCenter: parent.horizontalCenter
                text: ui.swapped
                      ? scores.visitor + "-" + scores.home
                      : scores.home + "-" + scores.visitor
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


