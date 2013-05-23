<cfscript>
	//objTwitter = CreateObject("component", "cfc.twitter");
	//GET THE USER ID OF THE PERSON THAT SIGNED IN AND STORE AS A SESSION VARIABLE FOR LATER USE
	session.twitter_user_id = application.twitter_cfc.getUserId();
	//GET THE USER DETAILS OF THE PERSON THAT SIGNED IN
	userDetails = application.twitter_cfc.getUserDetails();
	//GET THE USER LISTS OF THE PERSON THAT SIGNED IN
	userLists = application.twitter_cfc.getUserLists(session.twitter_user_id);
</cfscript>
<!--- <cfdump var="#userLists#"> --->
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<title>Twitter App</title>
	<meta name="description" content="">
	<meta name="author" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="css/base.css">
	<link rel="stylesheet" href="css/skeleton.css">
	<link rel="stylesheet" href="css/layout.css">
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="shortcut icon" href="img/favicon.gif">
	<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
</head>
<body>
<cfoutput>
	<form name="frmTwitterApp" action="userDetails.cfm">
	<div class="container" style="margin-top: 15px;">
		<div class="one-third column">
			<div style="position: relative;float: left;">
			    <div><img src="#userDetails.original_image#" /></div>
			</div>
			<div style="float: left;margin-left: 5px;">
				#userDetails.name#<br>
				<a href="https://twitter.com/#userDetails.screen_name#" target="_blank">
					@#userDetails.screen_name#
				</a>
			</div>
			<div style="float: left;">
				#userDetails.desc#<br>
				<a href="#userDetails.url#" target="_blank">
					#userDetails.url#
				</a>
			</div>
		</div>
		<div class="one-third column">
			<input type="button" name="sendTweet" id="sendTweet" value="Tweet">
			<span id="charCount">140</span>
			<textarea name="txtTweet" id="txtTweet" spellcheck="false" onKeyUp="chrCount(this);" onclick="this.focus();this.select()">
			</textarea>	
			<span id="tweetStatus" class="success"></span>
		</div>
		<div class="one-third column">
			Following : #userDetails.friends_count#<br/>
			Followers : #userDetails.followers_count#<br/>
			Tweets &nbsp;&nbsp;&nbsp;&nbsp;: <span id="countTweets">#userDetails.status_count#</span>
		</div>
		<hr />
		<div class="one-third column">
			<h3>Column 1</h3>
			<p>We will use these columns later for Timelines, your tweets and Lists.</p>
		</div>
		<div class="one-third column">
			<select name="selectType_1" id="selectType_1" class="SelectType">
				<cfloop query="userLists">
					<option value="#id#">#name#</option>
				</cfloop>
			</select>
			<h3>Column 2</h3>
			<p>We will use these columns later for Timelines, your tweets and Lists.</p>
		</div>
		<div class="one-third column">
			<h3>Column 3</h3>
			<p>We will use these columns later for Timelines, your tweets and Lists.</p>
		</div>
	</div>
	</form>
</cfoutput>
<script src="js/main.js"></script>
</body>
</html>
