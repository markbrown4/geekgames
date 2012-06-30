
# PRODUCTION
# http://games.sitepoint.com/
# Twitter
# key     ***REMOVED***
# secret  ***REMOVED***
# Facebook
# key     ***REMOVED***
# secret  ***REMOVED***

# STAGING
# http://geek-games-staging.herokuapp/
# Twitter
# key     ***REMOVED***
# secret  ***REMOVED***
# Facebook
# key     ***REMOVED***
# secret  ***REMOVED***

# DEV
# http://geek-games.dev/
# Twitter
# key     ***REMOVED***
# secret  ***REMOVED***
# Facebook
# key     ***REMOVED***
# secret  ***REMOVED***

Rails.application.config.middleware.use OmniAuth::Builder do

  case Rails.env
  when 'production'
    provider :twitter, '***REMOVED***', '***REMOVED***'
    provider :facebook, '***REMOVED***', '***REMOVED***'
  when 'staging'
    provider :twitter, '***REMOVED***', '***REMOVED***'
    provider :facebook, '***REMOVED***', '***REMOVED***'
  else
    provider :twitter, '***REMOVED***', '***REMOVED***'
    provider :facebook, '***REMOVED***', '***REMOVED***'
  end

end
