helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

get '/' do
    # hello
    @posts = Post.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if a user navigates too the path '/signup'
    @user = User.new    # setup empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

post '/signup' do
    
    # grab user input values from params
    email       = params[:email]
    avatar_url  = params[:avatar_url]
    username    = params[:username]
    password    = params[:password]
    bio         = params[:bio]
    
    #instatiate and save a User
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password, bio: bio}) 

    if @user.save
        redirect to('/login')
    else 
        erb(:signup)
    end
     
end

get '/login' do         # when a GET request comes into /login
    erb(:login)         # render app/views/login.erb
end

post '/login' do        # when we submit a form with an action of /login
    username = params[:username]
    password = params[:password]
    
    # 1. find user by username
    user = User.find_by(username: username)
    
    # 2. if that user exists
    if user && user.password == password
       session[:user_id] = user.id
       redirect to('/') 
    else
        @error_message = "Login failed"
        erb(:login)
    end

end

get '/logout' do
   session[:user_id] = nil
   redirect to('/')
end

get '/posts/new' do
    @post = Post.new
    erb(:"posts/new")
end

post '/posts' do
    photo_url = params[:photo_url]
    caption = params[:caption]
    
    # instantiate new Post
    @post = Post.new({ photo_url: photo_url, caption: caption, user_id: current_user.id })
    
    # if @post validates, save
    if @post.save
        redirect(to('/'))
    else
        # if it doesn't validate, print error message
        erb(:"posts/new")
    end
end

get '/posts/:id' do
    @post = Post.find(params[:id])      # find the post with the ID from the URL
    erb(:"posts/show")                  # render app/views/posts/show.erb
end

post '/comments' do
    # point values from params to variables
    text = params[:text]
    post_id = params[:post_id]
    
    #instatiate a comment with the values & assign the comment to the 'current_user'
    comment = Comment.new({text: text, post_id: post_id, user_id: current_user.id})
    
    #save the comment
    comment.save
    
    # redirect back to wherever we came from
    redirect(back)
end

post '/likes' do
    # point values from params to variables
    post_id = params[:post_id]
    
    # instantiate a like with the values & assign the comment to the "current_user"
    like = Like.new({post_id: post_id, user_id: current_user.id})
    like.save
    
    redirect(back)
end

delete '/likes/:id' do
    like = Like.find(params[:id])
    like.destroy
    redirect(back)
end

get "/:username" do
    username = params[:username]
    @userId = User.find_by(username: username)
    # @user_posts = @userId.posts_count
    erb(:userpage)
end
