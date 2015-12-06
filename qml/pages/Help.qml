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
    id: page
    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: header.height + text.height
        contentWidth: parent.width

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.replace(Qt.resolvedUrl("About.qml"))
            }
        }

        PageHeader {
            id: header
            title: qsTr("How to use")
        }
        Text {
            id: text
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
                topMargin: Theme.paddingLarge
            }
            width: parent.width
            wrapMode: Text.WordWrap
            color: Theme.primaryColor
            textFormat: Text.StyledText
            text: "<h2>" + qsTr("Two teams view") + "</h2>"
                  + qsTr("* Tap the “+” and “-“ buttons to change team scores. You can also add points using the cover actions. To change numbers of won rounds, tap first the small round numbers followed by tapping the +/- buttons. Get back to changing team scores by tapping the score numbers. Values are always automatically saved when modified.")

                  +"<br><h3>"+qsTr("PushUpMenu")+"</h3><p>"+
                  qsTr("* To reset the scores or the won rounds, use the 'Reset scores/rounds'-action in the PushUpMenu. This will reset the highlighted value. You have three seconds to cancel it by tapping the remorse notification.")
                  + "<br>" + qsTr("* Use 'Saved scores' in the PushUpMenu to fetch previous scores and rounds from the database. Beware that the saved values will be overwritten after any following changes.")
                  + "<br>" + qsTr("* To set new values directly, use the 'Set scores &amp; rounds' menu item and fill them in the corresponding text fields.")
                  + "<br>" + qsTr("* You can swap the scores by selecting 'Swap'.")

                  +"<br><h2>"+qsTr("Multiple player view")+"</h2><p>"+
                  qsTr("* To add a player, input the player's name into the textfield and press enter.")
                  + "<br>" + qsTr("* Click on a players name to remove them from the list. There is a 5 second remorse before deletation.")
                  + "<br>" + qsTr("* You can remove all players by using the PushUpMenu at the bottom of the list. There is also a 5 second remorse before deletation.")
                  + "<br><h4>" + qsTr("Please note that scores at the Multiple Player View won't be kept on exit (yet).")+ "</h4>"
        }
    }
}
