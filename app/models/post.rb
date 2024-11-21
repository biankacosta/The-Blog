class Post < ApplicationRecord
    has_one_attached :thumbnail
    validates :name, presence: true
    validates :title, presence: true, length: {maximum:110, minimum:10}
    validates :text, presence: true, length: {minimum:20}

    has_many :comments
end
