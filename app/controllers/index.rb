get '/' do
  @tweets = []
  erb :index
end

post '/tweet' do

  puts params[:tweet_content]
  puts '*' * 300
  @tweets = []
  Twitter.update(params[:tweet_content])
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