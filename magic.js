$(window).load(function initOverlays() {
	$('.photo .media img').each(function() {
	   $(this).parent().append('<span class="imageOverlay" style="display:none;"></span>');
   	});
	
	imageOverlayProduction()
});

$(function(){
	descriptionToggle();
	searchControl();
	zoomLink();	
	if(twitterUsername != "" && hideTwitter != '10') {
		getTwitterStatus();
	};
	credit();
});

function descriptionToggle() {
	$('a#descriptionToggle').fadeIn('slow').css({'display':'block'}).click(function() {
		$(this).toggleClass('active');
		if (jQuery.support.opacity) {
			$('.imageOverlay').fadeOut('fast');
		};
		$('#description').slideToggle('medium', function() {
			imageOverlayProduction()
			descriptionIcon()
		});		
		return false;
	});
};

function descriptionIcon() {
	if($('#description').height() > 48){
		$('#description .icon').show();
	}
	else{
		$('#description .icon').hide();
	}
	
}

function searchControl() {
	$('#search').click(function() {
		$(this).find('#searchForm').show();
		$('#tumblr').hide();
		$('#searchField').focus();
	});
	$('#searchField').blur(function() {
		if ($(this).val() == "") {
			$('#searchForm').hide();
			$('#tumblr').show();
		};
	});
};

function credit() {
	$('#footer').append('<div id="credit"><a href="http://prologuetheme.tumblr.com">Prologue Theme</a> by <a href="http://log.acryliccowboy.com">Hayden Hunter</a> edited by <a href="http://ob.czaj.net">ob.czaj.net</a></div>');
};

function zoomLink() {
	$('.zoom').each(function(){
		var destination = $(this).find('.destination');		
		if (destination.attr('title') == $(this).find('a').attr('href')) {
			destination.addClass('zoom');
			//$(this).find('a').attr('rel', 'lightbox');
			$(this).find('a').addClass('thickbox');
		};		
	});
	
};
	
function imageOverlayProduction() {	
	$('.photo').each(function() {
		var overlayTarget = $(this).find('.media img'); 
		var imageOffset = (overlayTarget.offset().top%272);
		var imageHeight = overlayTarget.height();
		var imageWidth = overlayTarget.width();
		var finalOffset = '-140px '+Math.round(-imageOffset+10)+'px';	
		
		if (jQuery.support.opacity) {
			// $(overlayTarget).siblings('span.imageOverlay').css({'background-color':'#f0f', 'font-size':'20px'});
			$(overlayTarget).parent().find('.imageOverlay').css({'height':imageHeight, 'width':imageWidth, 'background-position':finalOffset});
	
			// $(overlayTarget).siblings('span.imageOverlay').html(imageOffset);
			$('.imageOverlay').fadeIn('fast');
		};
		
		$(this).find('.media a').css({'width':imageWidth});
	});	
}

// Stolen from Twitter Blogger Badge
// http://twitter.com/badges/blogger
function relative_time(time_value) {
    var values = time_value.split(" ");
    time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
    var parsed_date = Date.parse(time_value);
    var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
    var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
    delta = delta + (relative_to.getTimezoneOffset() * 60);

    if (delta < 60) {
        return 'Posted less than a minute ago';
    } else if (delta < 120) {
        return 'Posted a minute ago';
    } else if (delta < (60 * 60)) {
        return 'Posted ' + (parseInt(delta / 60)).toString() + ' minutes ago';
    } else if (delta < (120 * 60)) {
        return 'Posted an hour ago';
    } else if (delta < (24 * 60 * 60)) {
        return 'Posted ' + (parseInt(delta / 3600)).toString() + ' hours ago';
    } else if (delta < (48 * 60 * 60)) {
        return 'Posted 1 day ago';
    } else {
        return (parseInt(delta / 86400)).toString() + ' days ago';
    }
}

// Parsing Strings With JQuery
// http://devkick.com/blog/parsing-strings-with-jquery
$.fn.clickUrl = function() {
    var regexp = /((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g;
	var regexpb = /\B@([_a-z0-9]+)/ig;
    this.each(function() {
        $(this).html(
        	$(this).html().replace(regexp, '<a href="$1">$1</a>')
		);
		$(this).html(
			$(this).html().replace(regexpb, '<a href="http://www.twitter.com/$1">@$1</a>')
        );
    });
    return $(this);
}

function getTwitterStatus() {
	$.getJSON('http://twitter.com/status/user_timeline/'+twitterUsername+'.json?count=1&callback=?', function(data){
		var twitterStatus = data[0]['text'];
		$('#twitterStatus').html(twitterStatus);
		$('#twitterStatus').clickUrl();
		$("#twitter .icon").attr('href', 'http://twitter.com/'+twitterUsername+'/status/'+data[0]['id']);
		
		$('#twitter .metaList .posted').html('<a href="http://twitter.com/'+twitterUsername+'/status/'+data[0]['id']+'"><span>'+relative_time(data[0]['created_at'])+'</span></a>');
		$('#twitter .metaList .author').html('by <a href="http://twitter.com/'+twitterUsername+'">@'+twitterUsername+'</a> from Twitter');
	
		$('#twitter').show();
	});
};
