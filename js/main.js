//CALL THE SEND TWEET FUNCTION IN TWITTER.CFC
function sendTweet(){
	var txtTweet = $("#txtTweet").val();
	var strURL = 'cfc/twitter.cfc?';
	strURL += 'method=sendTweet';
	strURL += '&strTweet=' + txtTweet;
	$.ajax({
		url: strURL,
		dataType: 'json',
		success: function(response){
			console.log(response);
		},
		error: function(ErrorMsg){
			console.log('Error');
			console.log(ErrorMsg);
		}
	})
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
