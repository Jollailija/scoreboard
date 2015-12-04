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
        property int activeView: 1
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

    initialPage: Component { //FirstPage {}
        Page {
            anchors.fill: parent

            SilicaFlickable {
                anchors.fill: parent
                contentHeight: header.height + text.height + Theme.paddingLarge
                contentWidth: parent.width
                PullDownMenu {
                    MenuItem {
                        text: qsTr("Open the app")
                        onClicked: pageStack.replace(Qt.resolvedUrl("pages/FirstPage.qml"))
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


    cover: CoverLoader {}
}


