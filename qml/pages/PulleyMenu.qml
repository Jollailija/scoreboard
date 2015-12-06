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
        text: ui.activeView === 1
              ? qsTr("Multiple player view")
              : qsTr("Two teams view")
        onClicked: ui.activeView === 1
                   ? (pageStack.replace(Qt.resolvedUrl("MultiplePlayers.qml")), ui.activeView = 2)
                   : (pageStack.replace(Qt.resolvedUrl("TTView.qml")), ui.activeView = 1)
    }

    MenuItem {
        text: qsTr("Help")
        onClicked: pageStack.push(Qt.resolvedUrl("Help.qml"))
    }
}
