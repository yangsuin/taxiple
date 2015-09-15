class List < ActiveRecord::Base
    belongs_to :mk_room
    has_one :user
    has_many :chat
end
