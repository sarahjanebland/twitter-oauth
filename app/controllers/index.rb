before do
  @consumer = OAuth::Consumer.new(ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], {
    :site=>"https://api.twitter.com" })
end

get '/' do
  @tweets = []
  erb :index
end

get '/twitter_token' do
  @request_token = @consumer.get_request_token(oauth_callback: "http://#{request.host_with_port}/oauth")
  session[:request_token] = @request_token
  redirect @request_token.authorize_url
end

get '/oauth' do
  @request_token = session[:request_token]
  @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session[:oauth] = {
    :access_token => @access_token.token,
    :access_token_secret => @access_token.secret      
  }
  @tweets = []
  erb :tweet
end


post '/tweet' do

  @client = Twitter::Client.new(
  :oauth_token => session[:oauth][:access_token],
  :oauth_token_secret => session[:oauth][:access_token_secret]
  )
  puts @client.inspect
  @client.update(params[:tweet_content])
  erb :index
end

post '/user' do
  @user = User.find_by_name(params[:username])
  begin
    @user = User.create(name: params[:username]) if Twitter.user(params[:username]) unless @user
  rescue
  end
  
  if @user
    @user.fresh!
    @tweets = @user.tweets.order("created_at DESC")
  else
    @tweets = []
  end
  erb :index
end

