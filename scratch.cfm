function sendTweet(e){
	var txtTweet = $("#txtTweet").val();
	var strURL = 'cfc/twitter.cfc?';
	strURL += 'method=sendTweet';
	strURL += '&strTweet=' + txtTweet;
	$.ajax({
		url: strURL,
		dataType: 'script',
		success: function(response){
			console.log(response);
			//console.log('statusText  : ' + response.statusText);
			//console.log('status  : ' + response.status);
			$("#tweetStatus").removeClass('Failure').addClass('Success');
			$("#tweetStatus").html('Tweet Sent');
			$("#txtTweet").text('');
		},
		error: function(ErrorMsg){
			console.log(ErrorMsg);
			//console.log('statusText  : ' + ErrorMsg.statusText);
			//console.log('status  : ' + ErrorMsg.status);
			$("#tweetStatus").removeClass('Success').addClass('Failure');
			$("#tweetStatus").html('ERROR - Tweet not sent');
		}
	})
}