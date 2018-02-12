class Note < ApplicationRecord
    validates :japanese, {presence: true, length: {maximum: 20}}
    validates :korean, {presence: true, length: {maximum: 20}}
    validates :fq, {presence: true}
end
