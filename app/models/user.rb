class User <ActiveRecord::Base
    has_many :posts
    has_many :comments
    has_many :likes
    has_many :followers
    has_many :following

    validates_presence_of :email, :avatar_url, :username, :password
    validates_uniqueness_of :email, :username
    
    def following_count
        Follower.where(user_id: self.id).count
    end
    
    def followers_count
        Follower.where(followers: self.id).count
    end
    
    def isFollowing
        Follower.where(user_id: current_user.id, following: self.id )
    end
    
    def posts_count 
       Post.where(user_id: self.id) 
    end
    
    # def avatar
    #     if self.avatar_url
    #       self.avatar_url 
    #     end
    # end
    
    
end