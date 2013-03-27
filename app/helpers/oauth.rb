helpers do

	def prepare_access_token(oauth_token, oauth_token_secret)
	  consumer = OAuth::Consumer.new("APIKey", "APISecret",
	    { :site => "https://api.twitter.com",
	      :request_token_path => '/oauth/request_token',
	      :access_token_path => '/oauth/access_token',
	      :authorize_path => '/oauth/authorize',
	      :scheme => :header
	    })
	end

end