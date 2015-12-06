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
    allowedOrientations: Orientation.All

    ListModel {id: playerListModel}
    SilicaListView {
        id: listView
        PulleyMenu {}
        RemorsePopup {id: remorsePopUp;anchors.top: parent.top}

        clip: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: newPlayer.top
        }
        model: playerListModel
        header: PageHeader { title: qsTr("Scoreboard") }
        delegate: Item {
            id: delegate
            width: parent.width
            height: add.height
            property int playerScore
            function showRemorseItem() {
                var idx = index
                remorse.execute(delegate, qsTr("Removing player"), function() { playerListModel.remove(idx) } )
            }
            RemorseItem {id: remorse}
            MouseArea {
                anchors {
                    left: delegate.left
                    top: delegate.top
                    bottom: delegate.bottom
                }
                width: delegate.width * 0.6
                onClicked: showRemorseItem()
            }
            Label {
                text: model.playerName + ": " + playerScore
                color: Theme.primaryColor
                font.pixelSize: mainWindow.applicationActive ? Theme.fontSizeMedium : Theme.fontSizeHuge // Thanks Leszek Lesner for this trick
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin


            }
            IconButton {
                id: add
                anchors {
                    right: remove.right
                    rightMargin: Theme.paddingLarge * 3
                }
                icon.source: "image://theme/icon-m-add"
                onClicked: playerScore ++
            }
            IconButton {
                id: remove
                anchors {
                    right: delegate.right
                    rightMargin: Theme.paddingLarge
                }
                icon.source: "image://theme/icon-m-remove"
                enabled: playerScore > 0
                onClicked: playerScore --
            }

        }
        VerticalScrollDecorator {}

        PushUpMenu {
            MenuItem {
                text: qsTr("Remove all players")
                onClicked: remorsePopUp.execute(qsTr("Removing players"),function(){playerListModel.clear()})
            }
        }

    }

    TextField {
        id: newPlayer
        width: parent.width
        anchors.bottom: parent.bottom
        inputMethodHints: Qt.ImhNoPredictiveText
        validator: RegExpValidator { regExp: newPlayer.focus === true
                                             ? (/^[a-öA-Ö0-9]{1,20}$/)
                                             : (/^[a-öA-Ö0-9]{,20}$/)} // red looks bad :)
        label: qsTr("Player name")
        placeholderText: qsTr("Add a new player")
        focus: true
        EnterKey.onClicked: {
            if (errorHighlight)
                newPlayer.focus = true
            else
            {playerListModel.append({"playerName": newPlayer.text})
                text = ""
                parent.focus = true;
            }
        }
    }


}

