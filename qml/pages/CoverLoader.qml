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

CoverBackground {
    Loader {
        anchors.fill: parent

        sourceComponent: ui.activeView === 1 // future proof?
                         ? ttCover
                         : mpCover


        Component {

            id: ttCover // Cover for two teams mode

            Item {
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
}
