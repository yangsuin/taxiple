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