component {
 
    public function init(userid) {
        variables.userid = arguments.userid;
        variables.consumer_key = application.twitter_consumer_key;
        variables.consumer_secret = application.twitter_consumer_secret;
        variables.access_token = session.twitter_access_token;
        variables.access_secret = session.twitter_access_token_secret;
        return this;
    }
     
    //GET THE GENERAL USER DETAILS
    public struct function getUserDetails(objT4J) {
        //DEFINE USER STRUCTUE
        var user = {};
        //CALL TWITTER API 
        userDetails = objT4J.showUser(#session.twitter_user_id#);

        //GET NAMES, DESCRIPTIONS ETC
        user.screen_name = userDetails.getScreenName();
        user.name = userDetails.getName();
        user.desc = userDetails.getDescription();
        user.lang = userDetails.getLang();
        user.location = userDetails.getLocation();

        //GET COUNTS
        user.fav_count = userDetails.getFavouritesCount();
        user.followers_count = userDetails.getFollowersCount();
        user.friends_count = userDetails.getFriendsCount();
        user.listed_count = userDetails.getListedCount();

        //GET IMAGES
        user.small_image = userDetails.getMiniProfileImageURL();
        user.small_image_https = userDetails.getMiniProfileImageURLHttps();
        user.original_image = userDetails.getOriginalProfileImageURL();
        user.original_image_https = userDetails.getOriginalProfileImageURLHttps();

        //GET URL'S
        user.url = userDetails.getURL();
        user.desc_urls = userDetails.getDescriptionURLEntities();
        user.url_entity_display_url = userDetails.getURLEntity().getDisplayURL();
        user.url_entity_end = userDetails.getURLEntity().getEnd();
        user.url_entity_expanded_url = userDetails.getURLEntity().getExpandedURL();
        user.url_entity_start = userDetails.getURLEntity().getStart();
        user.url_entity_url = userDetails.getURLEntity().getURL();
        user.url_entity_hashcode = userDetails.getURLEntity().hashCode();

        //GET DATE AND TIME STUFF
        user.created_date = userDetails.getCreatedAt();
        user.timezone = userDetails.getTimeZone();
        user.utc_offset = userDetails.getUtcOffset();

        //GET BOOLEAN (YES/NO) STUFF
        user.is_contributors_enabled = userDetails.isContributorsEnabled();
        user.is_follow_request_sent = userDetails.isFollowRequestSent();
        user.is_geo_enabled = userDetails.isGeoEnabled();
        user.is_protected = userDetails.isProtected();
        user.is_show_all_inline_media = userDetails.isShowAllInlineMedia();
        user.is_translator = userDetails.isTranslator();
        user.is_verified = userDetails.isVerified();

        //GET MISC STUFF
        user.hashcode = userDetails.hashCode();

        //GET STATUS STUFF
        user.status_count = userDetails.getStatusesCount();

        //writedump(var=userDetails);
        return user;
    }
    //SEND A TWEET
    remote string function sendTweet(strTweet) {
        var txtTweet = arguments.strTweet;               
        //CONFIGURE twitter4j
        configBuilder = createObject("java", "twitter4j.conf.ConfigurationBuilder");
        configBuilder.setOAuthConsumerKey(#application.twitter_consumer_key#);
        configBuilder.setOAuthConsumerSecret(#application.twitter_consumer_secret#);
        configBuilder.setOAuthAccessToken(#session.twitter_access_token#);
        configBuilder.setOAuthAccessTokenSecret(#session.twitter_access_token_secret#);
        configBuilder.setJSONStoreEnabled(true);
        config = configBuilder.build();
        twitterFactory = createObject("java", "twitter4j.TwitterFactory").init(config);
        t4j = twitterFactory.getInstance();
        sendTweet =  t4j.updateStatus(txtTweet);
        return sendTweet;
    }
}
