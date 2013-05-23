//CALL THE SEND TWEET FUNCTION IN TWITTER.CFC
function sendTweet(){
	var txtTweet = $("#txtTweet").val();
	var strURL = 'cfc/twitter.cfc?';
	strURL += 'method=sendTweet';
	strURL += '&strTweet=' + txtTweet;
	var doTweet = $.ajax({
		url: strURL,
		dataType: 'html'
	});
	doTweet.done(function(msg) {
		$("#tweetStatus").removeClass('Failure').addClass('Success');
		$("#tweetStatus").html('Tweet Sent');
		$("#txtTweet").html('');
		$("#countTweets").html(parseInt($("#countTweets").html())+1);
	});	
	doTweet.fail(function(jqXHR, textStatus) {
		$("#tweetStatus").removeClass('Success').addClass('Failure');
		$("#tweetStatus").html('ERROR - ' + textStatus);
	});
}
//COUNT THE CHARACTERS IN THE TWEET
function chrCount(txtTweet) {
    var charCount = document.getElementById('charCount');
    charQty = 140 - txtTweet.value.length;
    charCount.innerHTML = charQty;
}
//SEND A TWEET BY CALLING AJAX FUNCTION THAT CALLS A CFC REMOTELY
$("#sendTweet").click(function() {
  sendTweet();
});
$("#txtTweet").focusin(function(){
  $("#tweetStatus").text('');
});
