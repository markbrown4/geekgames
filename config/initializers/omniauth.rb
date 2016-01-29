
# PRODUCTION
# http://games.sitepoint.com/
# Twitter
# key     
# secret  
# Facebook
# key     
# secret  

# STAGING
# http://geek-games-staging.herokuapp/
# Twitter
# key     
# secret  
# Facebook
# key     
# secret  

# DEV
# http://geek-games.dev/
# Twitter
# key     
# secret  
# Facebook
# key     
# secret  

Rails.application.config.middleware.use OmniAuth::Builder do

  case Rails.env
  when 'production'
    provider :twitter, '', ''
    provider :facebook, '', ''
  when 'staging'
    provider :twitter, '', ''
    provider :facebook, '', ''
  else
    provider :twitter, '', ''
    provider :facebook, '', ''
  end

end
