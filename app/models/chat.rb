class Chat < ActiveRecord::Base
    belongs_to :list
    has_many :user
end
