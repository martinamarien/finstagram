class Post <ActiveRecord::Base
    belongs_to :user
    has_many :likes
    has_many :comments
    
    # validations in between association definitions and methods!
    validates_presence_of :photo_url, :user
    
    def humanized_time_ago
        time_ago_in_seconds = Time.now - self.created_at
        time_ago_in_minutes= time_ago_in_seconds / 60
        
        if time_ago_in_minutes >= 60
            if time_ago_in_minutes >= (60*24) && time_ago_in_minutes < ((60*24)*7)
                "#{(time_ago_in_minutes/(60*24)).to_i}d"
            elsif time_ago_in_minutes >= ((60*24)*7)
                "#{(time_ago_in_minutes/((60*24)*7)).to_i}w"
            else
                "#{(time_ago_in_minutes / 60).to_i}h"
            end    
        else
            "#{time_ago_in_minutes.to_i}m"
        end
    end
    
    
    def like_count
        self.likes.size
    end
    
    def comment_count
        self.comments.size
    end


end