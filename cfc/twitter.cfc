component {
    public function init_twitter() {
        //CONFIGURE twitter4j
        configBuilder = createObject("java", "twitter4j.conf.ConfigurationBuilder");
        configBuilder.setOAuthConsumerKey(#application.twitter_consumer_key#);
        configBuilder.setOAuthConsumerSecret(#application.twitter_consumer_secret#);
        configBuilder.setOAuthAccessToken(#application.twitter_access_token#);
        configBuilder.setOAuthAccessTokenSecret(#application.twitter_access_token_secret#);
        configBuilder.setJSONStoreEnabled(true);
        config = configBuilder.build();
        twitterFactory = createObject("java", "twitter4j.TwitterFactory").init(config);
        variables.t4j = twitterFactory.getInstance();
        return this;
    }
    //GET THE GENERAL USER DETAILS
    public struct function getUserDetails() {
        //CONFIGURE twitter4j
        init_twitter();
        //DEFINE USER STRUCTUE objT4J
        var user = {};
        //CALL TWITTER API 
        userDetails = t4j.showUser(#session.twitter_user_id#);
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
        //RETURN THE USER STRUCTURE
        return user;
    }
    //SEND A TWEET
    remote string function sendTweet(strTweet) {
        //CONFIGURE twitter4j
        init();
        //SEND THE TWEET
        sendTweet =  t4j.updateStatus(arguments.strTweet);
        //RETURN THE SEND STATUS
        return sendTweet;
    }
    //GET USER ID
    remote string function getUserId() {
        //CONFIGURE twitter4j
        init_twitter();
        //writeDump(var=application);
        //writeDump(var=session);
        //abort;
        //SEND THE TWEET
        userId =  t4j.verifyCredentials().getID();
        //RETURN THE SEND STATUS
        return userId;
    }
    //GET USERS LISTS
    remote query function getUserLists(userid) {
        //CONFIGURE twitter4j
        init_twitter();
        //DEFINE USER LIST QUERY
        var userLists = querynew("id, name, member_count", "Integer, VarChar, Integer");
        //GET THE USER LISTS
        getLists =  t4j.getUserLists(#arguments.userid#);
        //BUILD THE USER LIST QUERY
        for (i=1;i LTE ArrayLen(getLists);i=i+1) {
           newRecord = queryAddRow(userLists);
           newRecord = querySetCell(userLists, "id", getLists[i].getId());
           newRecord = querySetCell(userLists, "name", getLists[i].getName());
           newRecord = querySetCell(userLists, "member_count", getLists[i].getMemberCount());
        }
        //userListsSorted = sortUserList(userLists);
        //SORT THE USER LIST BY NAME
        //ulist = new cf_cfc.query();
        //userLists.setDBType("query");
        //userLists.setAttributes(sourceQuery=userLists);
        //userLists.setSQL("select * from sourceQuery order by name");
        ulist = new cf_cfc.query(sql="SELECT  * from sourceQuery order by name",dbtype="query",sourceQuery=getLists);
        result = ulist.execute().getresult();
        //RETURN THE SORTED USER LIST QUERY
        return result;
        //local.qoq.execute(sql="select * from sourceQuery order by name", dbtype="query");
    }
    //SORT IT
    remote query function sortUserList(originalList) {
        ulist = new cf_cfc.query();
        ulist.setDBType("query");
        ulist.setAttributes(sourceQuery=originalList);
        ulist.setSQL("select * from sourceQuery order by name");
        listSorted = ulist.execute().getresult();
        //RETURN THE SORTED USER LIST QUERY
        return listSorted;
    }
}
