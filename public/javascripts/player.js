(function($){
    var settings;

    $.fn.robodisco = function(callerSettings) {
        settings = $.extend(
        {   playerSelector : "#player_box",
            trackSelector : ".track",
            videoSelector : ".video",
            videoListSelector : ".videos_list",
            moreVideosSelector : ".more_videos",
            searchUrl : "retrieve_videos"
        }, callerSettings || {});

        settings.nextTrackSelector = ".track.next";
        settings.currentTrackSelector = ".track.current";
        settings.nextPage = 1; //for video results - start at first page.

        var findVideos = function(params){
            $.ajax({
                type: "GET",
                url:  settings.searchUrl,
                data: {track_info : params.query, page : settings.nextPage },
                dataType : 'html',
                success: function(result) {
//                    $.inspect( $(result).size());
                    if ( $(result).size() ) {
                        var $video_container = $(settings.videoListSelector);
                        if ( params.newSong ) {
                            $video_container.empty();
                            $video_container.append(result);
                            $(settings.moreVideosSelector).trigger("enableMoreVideosLink");
                            $(settings.nextTrackSelector).trigger("videosFound");
                        }
                        else {
                            $video_container.append(result);
                        }
                    } else {
                        if( params.newSong  ){
                            $(settings.nextTrackSelector).trigger("noVideosFound");
                            $(settings.moreVideosSelector).trigger("disableMoreVideosLink");
                        } else {
                            $(settings.moreVideosSelector).trigger("disableMoreVideosLink");
                        }
                    }
                }
            });
        };

        //finds the next track to play after given track. Wraps to
        //beginning if given track is last in list.
        var getNeighbouringTrack = function($trackLi){
            return $trackLi.is(":last-child") ? $(settings.trackSelector).first() : $trackLi.next().find(".track");
        };

        //called by tubeplayer when playing video reaches its end
        var onEndOfVideo = function(){
            getNeighbouringTrack( $(settings.currentTrackSelector).parent("li") ).click();
        };


        //removes class of next from any track element then adds class of next to given track
        var setNext = function($track){
            $(settings.nextTrackSelector).removeClass("next");
            $track.addClass("next");
        };

        var setCurrent = function($track){
            $(settings.currentTrackSelector).removeClass("current");
            $track.addClass("current");
        };

        var trackDetails = function($track){
            var title = $track.find(".title").text();
            var artist = $track.find(".artist").text();
            return artist + " " + title
        };

        //set listeners
        $(settings.trackSelector).click(function(){
            setNext($(this));
            settings.nextPage = 1;
            var background = $(this).parent("li").css("background-color");
            $(this).parent("li").pulse(
            { opacity : [1,1], backgroundColor: [ 'white', background] },
            { duration : 100, times : 3,
                complete: function() {
                    $(this).removeAttr("style");
                    findVideos({query : trackDetails($(this)), newSong : true});
                }
            });
            return false;
        });

        $(settings.trackSelector).bind("noVideosFound", function(){
            $(this).trigger("removePlayStatus");
            var background = $(this).parent("li").css("background-color");
            $(this).parent("li").pulse(
            { opacity : [1,0.8], backgroundColor: [ 'red', background] },
            { duration : 500, times : 3,
                complete: function() {
                    $(this).removeAttr("style");
                    $(this).slideUp('slow', function() {
                        $(this).appendTo("#unplayable").slideDown('slow');
                    });
                    getNeighbouringTrack($(this)).trigger("click");
                }
            });
        });

        $(settings.trackSelector).bind("play", function(){
            $(this).trigger("setPlayStatus");
            $(settings.playerSelector).trigger("play", [$(this).data("youtubeID")]);
        });

        $(settings.trackSelector).bind("removePlayStatus", function(){
            $(this).parent("li").removeClass("current_track");
        });

        $(settings.trackSelector).bind("setPlayStatus", function(){
            $(settings.trackSelector).parent("li").removeClass("current_track");
            $(this).parent("li").addClass("current_track");
        });

        $(settings.trackSelector).bind("setVideo", function(event, youtubeID){
            $(this).data("youtubeID", youtubeID);
        });

        $(settings.trackSelector).bind("videosFound", function(){
            setCurrent($(this));
            if (!$(this).data("youtubeID") ) {  //if not already set a video id then set to first video result
                $(this).data("youtubeID", $(".video:first").attr("id"));
            }
            $(this).trigger("play");
        });

        $(settings.moreVideosSelector).click(function(){
            settings.nextPage += 1;
            findVideos({query : trackDetails($(settings.currentTrackSelector)), newSong : false} );
            return false;
        });

        $(settings.moreVideosSelector).bind("disableMoreVideosLink", function(){
            $(this).text("No More Videos");
            $(this).addClass("disabled");

        });

        $(settings.moreVideosSelector).bind("enableMoreVideosLink", function(){
            $(this).text("More Videos");
            $(this).removeClass("disabled");
        });

        $(settings.videoSelector).live("click", function(){
            $(settings.currentTrackSelector).trigger("setVideo", [$(this).attr("id")]);
            $(settings.currentTrackSelector).trigger("play");
        });

        $(settings.playerSelector).bind("play", function(event, ytId){
            var $player = $(this);
            //initialize tubeplayer if required
            if ( $player.is(":empty") ) {
                $player.tubeplayer({
                    width: 600, // the width of the player
                    height: 450, // the height of the player
                    allowFullScreen: "true", // true by default, allow user to go full screen
                    initialVideo: ytId, // the video that is loaded into the player
                    playerID: "current_youtube_song", // the ID of the embedded youtube player
                    preferredQuality: "default",// preferred quality: default, small, medium, large, hd720
                    onPlay: function(id){}, // after the play method is called
                    onPause: function(){}, // after the pause method is called
                    onStop: function(){}, // after the player is stopped
                    onSeek: function(time){}, // after the video has been seeked to a defined point
                    onMute: function(){}, // after the player is muted
                    onUnMute: function(){}, // after the player is unmuted
                    onPlayerEnded: onEndOfVideo //pass my custom function
                });
            }
            $player.tubeplayer("play", ytId);
        });

        $(settings.trackSelector).first().trigger("click");
    };

})(jQuery);


$(function() {
    $("#tracklisting").robodisco({})
});
