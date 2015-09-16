# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!  :email => '1234@1234.com', :password => '12341234', :password_confirmation => '12341234'
user = User.create! :email => 'antmgu@naver.com', :password => '12341234', :password_confirmation => '12341234'
user = User.create! :email => 'seunghyun257@naver.com', :password => '12341234', :password_confirmation => '12341234'
user = User.create! :email => 'qwer@qwer.com', :password => '12341234', :password_confirmation => '12341234'
user = User.create! :email => 'asdf@asdf.com', :password => '12341234', :password_confirmation => '12341234'
user = User.create! :email => '1111@1111.com', :password => '11111111', :password_confirmation => '11111111'
user = User.create! :email => '1@1.com', :password => '11111111', :password_confirmation => '11111111'
user = User.create! :email => '2@2.com', :password => '22222222', :password_confirmation => '22222222'
user = User.create! :email => '3@3.com', :password => '33333333', :password_confirmation => '33333333'


# 안돼 ㅠㅠㅠㅠ
# MkRoom.create! :user_id => "1", :course => "단국대 -> 죽전역", :user_hour => 2, :user_minute => 30, :girl_only => "0", finish => false, :num_member_limit => "4", :num_of_user_join => "2", :finish => false
# MkRoom.create! :user_id => "2", :course => "집현재 -> cu", :user_hour => 2, :user_minute => 30, :girl_only => "0", finish => false, :num_member_limit => "4", :num_of_user_join => "2", :finish => false
# MkRoom.create! :user_id => "3", :course => "강남역 -> 부산", :user_hour => 2, :user_minute => 30, :girl_only => "0", finish => false, :num_member_limit => "4", :num_of_user_join => "2", :finish => false