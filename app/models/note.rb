class Note < ApplicationRecord
    validates :japanese, {presence: true, length: {maximum: 20}}
    validates :korean, {presence: true, length: {maximum: 20}}
    validates :fq, {presence: true}
    validates :user_id, {presence: true}
    
    def user
        return User.find_by(id: self.user_id)
    end
    
    
    
end
