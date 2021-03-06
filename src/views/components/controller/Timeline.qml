import QtQuick 2.2

import "../../../utils/"

Item {
    property real duration: 0
    property real positionTime: 0
    property real position: Math.floor(positionTime / duration * width)

    signal end()


    Utils{id: utils}
    Item {
        id: timeItem
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 25
        Text {
            id: currentPosition
            font.pixelSize: 25
            font.bold: true
            color: "white"
            text: timeFromMS(positionTime)
        }
        Text {
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 25
            font.bold: true
            color: "white"
            text: timeFromMS(duration)
        }
    }
    Timer {
        property real startTime: 0
        id: imageTimer
        interval: 1000
        repeat: true
        onTriggered: {
            startTime += 1000;
            positionTime = startTime;
            if (startTime > duration) {
                startTime = 0;
                imageTimer.stop();
                end();
            }
        }
    }
    Rectangle {
        anchors.top: timeItem.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.right: parent.right
        height: 10
        clip: true
        color: "gray"
        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: position
            color: "white"
        }
    }
    function setDuration(time) {
        duration = utils.timeToMS(time);
        imageTimer.start();
    }
    function timeFromMS(ms) {
        var sec_num = Math.floor(ms / 1000);
        var hours = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);
        if (hours < 10) {
            hours = "0" + hours;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        var time = hours + ':' + minutes + ':' + seconds;
        return time;
    }
}
