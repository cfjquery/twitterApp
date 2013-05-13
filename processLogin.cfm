<cfscript>
	if(IsDefined("url.loginType") and url.loginType eq "twitter"){
		//CONFIGURE twitter4j
		configBuilder = createObject("java", "twitter4j.conf.ConfigurationBuilder");
		configBuilder.setOAuthConsumerKey(#application.twitter_consumer_key#);
		configBuilder.setOAuthConsumerSecret(#application.twitter_consumer_secret#);
		configBuilder.setJSONStoreEnabled(true);
		config = configBuilder.build();
		twitterFactory = createObject("java", "twitter4j.TwitterFactory").init(config);
		t4j = twitterFactory.getInstance();
		// PROCESS THE LOGIN
		if(NOT structKeyExists(url, "oauth_verifier")){
			//REDIRECT THE USER TO THE TWITTER SITE FOR AUTHENTICATION
			session.requestToken = t4j.getOAuthRequestToken("#application.redirect_uri#");
			location(url="#session.requestToken.getAuthorizationURL()#" addtoken="No");
		}
		else{
			//WHEN USER RETURNS BACK FROM AUTHENTCATION, SET THE SESSION VARIABLES
			getAccessToken = t4j.getOAuthAccessToken(session.requestToken, url.oauth_verifier);
			session.twitter_access_token = getAccessToken.getToken();
			session.twitter_access_token_secret =  getAccessToken.getTokenSecret();
			location(url="main.cfm");
		}
	}
</cfscript>
