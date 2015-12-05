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

//Yes, I copied the code from my Nettiradio's about page. Recycling!

Page {
    id: page
    property var textAlignment: TextInput.AlignLeft
    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: header.height + version.height + text.height + links.height + Theme.paddingLarge //+ flattr.height
        contentWidth: parent.width
        VerticalScrollDecorator {}

            PageHeader {
                id: header
                title: qsTr("About")
            }
            Button {
                id: version
                anchors.top: header.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Version " + "0.2.0" + "-" + "3" //I don't know how to automate this just yet...
                onClicked: Qt.openUrlExternally("https://github.com/Jollailija/scoreboard/blob/master/rpm/harbour-scoreboard.changes")
            }
            TextArea {
                id: text
                anchors {
                    top: version.bottom
                    left: parent.left
                    right: parent.right
                }
                readOnly: true
                text: qsTr("A simple scoreboard app for Sailfish OS. Made by jollailija. Icon by Moth.")
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: textAlignment
            }

            Row {
                id: links
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: text.bottom
                spacing: Theme.paddingLarge


                Button {
                    text: "GitHub"
                    onClicked: Qt.openUrlExternally("https://github.com/jollailija/scoreboard/")
                }
                Button {
                    text: "OpenRepos"
                    onClicked: Qt.openUrlExternally("https://openrepos.net/content/jollailija/scoreboard")
                }
            }
            /*
              Disabled until I get the right url
            Button {
                anchors.top: links.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                id: flattr
                text: "Lahjoita Flattrin kautta"
                onClicked: Qt.openUrlExternally("https://flattr.com/thing/4382591/Jollailijanettiradio-on-github")
            }*/
    }
}
