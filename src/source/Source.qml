import QtQuick 2.2

Item {
    property var config: undefined 
    property var storage: Storage {}

    function ajax(url, callback) {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState != xhr.DONE) {
                return false;
            }
            if (callback) {
                callback(xhr.responseText ? JSON.parse(xhr.responseText) : null);
            }
        }
        xhr.send();
        return true;
    }

    function getChannels(callback) {
        var url = config.serviceServerPath + "/Channels/getChannels.json";
        return ajax(url, callback);
    }

    function getChannelById(channelId, callback) {
        var url = config.serviceServerPath + "/Channels/getChannelById.json?channelId=" + channelId;
        return ajax(url, callback);
    }

    function getProgramToPlay(channelId, playlistId, order, playlistOrder, finishedPlaylistId, callback) {
        var url = config.serviceServerPath + 
        "/Programs/getProgramToPlay.json?" + 
        "channelId=" + channelId + 
        "&stbDate=" + Math.round(Date.now() / 1000) +
        (!!playlistId ? "&playlistId=" + playlistId : "") + 
        "&programOrder=" + order +
        "&playlistOrder=" + playlistOrder + 
        (!!finishedPlaylistId ? "&finishedPlaylist=" + finishedPlaylistId : "");
        return ajax(url, callback);
    }

    function getVodPrograms(channelId, nbProgramByCategory, callback) {
        nbProgramByCategory = nbProgramByCategory || 10;
        var url = config.serviceServerPath +
        "/Programs/getProgramsGroupedByCategory.json?channelId=" + channelId +
        "&nbProgramByCategory=" + nbProgramByCategory;
        console.log(url);
        return ajax(url, callback);
    }
}
