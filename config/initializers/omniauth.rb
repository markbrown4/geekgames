# Twitter oath
# key     ***REMOVED***
# secret  ***REMOVED***

# facebook
# key     ***REMOVED*** 
# secret  ***REMOVED***

# Site URL    http://geek-games.dev/

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, '***REMOVED***', '***REMOVED***'
  provider :facebook, '***REMOVED***', '***REMOVED***'

  # case Rails.env
  #   when 'production'
  #     provider :twitter, '***REMOVED***', '***REMOVED***'
  #     provider :facebook, '***REMOVED***', '***REMOVED***'
  #   else
  #     provider :twitter, '***REMOVED***', '***REMOVED***'
  #     provider :facebook, '***REMOVED***', '***REMOVED***'
  # end

end
