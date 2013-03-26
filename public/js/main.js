$(document).ready(function(){
	$('#send_tweet').on('submit', function(e){
		e.preventDefault();
		var tweet = $("#send_tweet input[type='text']").val();
		var myTweetForm = new TweetForm(tweet);
		myTweetForm.disable();
		myTweetForm.sendWorkingMsg();
		myTweetForm.sendTweet();
	});
});

function TweetForm(tweet) {
	this.tweet = tweet;
	this.submitButton = "#send_tweet input[type='submit']";
	this.textField = "#send_tweet input[type='text']";
	this.msgPlace = ".msg-place";
}

TweetForm.prototype.disable = function(){
	$(this.submitButton).attr('disabled', 'disabled');	
	$(this.textField).attr('disabled', 'disabled');
};

TweetForm.prototype.sendWorkingMsg = function(){
	$(this.msgPlace).html('Sending tweet..........');
};

TweetForm.prototype.sendTweetedMsg = function(){
	$(this.msgPlace).html('Tweet sent~!');
};

TweetForm.prototype.sendErrorMsg = function(){
	$(this.msgPlace).html('Tweet botched, please try again!');
};

TweetForm.prototype.removeDisabled = function(){
	$(this.submitButton).removeAttr('disabled');	
	$(this.textField).removeAttr('disabled');	
};

TweetForm.prototype.clearTweetField = function(){
	$(this.textField).val("");
};

TweetForm.prototype.sendTweet = function(){
	var theForm = this;
	
	$.ajax({
		url: '/tweet',
		type: 'post',
		data: {tweet_content : this.tweet},
		context: this,
	})
	 .done(function(data){
	 	console.log(this);
	 	theForm.removeDisabled();
		theForm.sendTweetedMsg();
		theForm.clearTweetField();
	})
	 .fail(function(){
	 	theForm.sendErrorMsg();
	 	theForm.removeDisabled();
	});
};