class Post < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 20}}
    validates :content, {presence: true, length: {maximum: 500}}
    
    def user
        return User.find_by(id: self.user_id)
    end
    
    def comments
        return Comment.where(post_id: self.id) 
    end
end
