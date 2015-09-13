class TaxipleController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :intro, :room_page, :menual] #로그인한 유저만 등록 가능하게함.
  def index
  end

  def intro
  end
  
  def room_page
  end
  
  def menual
  end
  
  def pra
  end
  
  def create
    @mkroom = MkRoom.create(user_id: current_user.id,
                  course: params[:course],
                  user_hour: params[:user_hour].to_i,
                  user_minute: params[:user_minute].to_i,
                  num_member_limit: params[:num_member_limit].to_i,
                  girl_only: params[:girl_only].to_i)

    @list = List.create(mk_room_id: @mkroom.id,
                        person_1: current_user.email,
                        person_2: nil,
                        person_3: nil,
                        person_4: nil)
    
    User.where(id: current_user.id).each do |user|
      user.list_id = @list.id
      user.register_to_use = params[:register_to_use]
      user.save
    end
    redirect_to "/taxiple/page4"
  end
  
  def page4 #인원 긊구 순으로 정렬
    Time.zone = 'Seoul'
    @time = Time.zone.now
    @t = @time.day * 24 * 60 + @time.hour * 60 + @time.min
    
    
    @mkroom = MkRoom.all    
    # @room_info = MkRoom.where(user_id: current_user.id)
    @room_info = MkRoom.where(user_id: current_user.id)
    #@mkroom=MkRoom.where(user_id: 1).uniq
    @now_user = User.where(id: current_user.id)
    
    @now_user.each do |x|
      @register_user = x.register_to_use
    end
    
    @user = User.all
    @list = List.all
    @now_list = List.where(person_1: current_user.email) #현재 유저의 방정보는 person_1~4로 찾아야한다.
    
    #입력창에서 방장 / 참가자 / 구경꾼에 따라 보여주는 화면 설정
    if !@list.where(person_2: current_user.email).empty?
      @list.where(person_2: current_user.email).each do |list|
        @list_mkroom_id = list.mk_room_id
      end
    elsif !@list.where(person_3: current_user.email).empty?
      @list.where(person_3: current_user.email).each do |list|
        @list_mkroom_id = list.mk_room_id
      end
    elsif !@list.where(person_4: current_user.email).empty?
      @list.where(person_4: current_user.email).each do |list|
        @list_mkroom_id = list.mk_room_id
      end
    end
    render layout: "materialize"
  end
  
  def page4_time
    Time.zone = 'Seoul'
    @time = Time.zone.now
    @t = @time.day * 24 * 60 + @time.hour * 60 + @time.min
    
    @mkroom = MkRoom.all    
    # @room_info = MkRoom.where(user_id: current_user.id)
    @room_info = MkRoom.where(user_id: current_user.id)
    #@mkroom=MkRoom.where(user_id: 1).uniq
    
     #현재 시간 설정  for 비교
    Time.zone = 'Seoul'
    @time = Time.zone.now
    @time_hour = @time.hour.to_i * 60
    @now_time_compare = @time_hour + @time.min.to_i
    #유저가 입력한 시간 설정 for 비교는 page4_time 페이지 자체에 있음
    
    @now_user = User.where(id: current_user.id)
    
    @now_user.each do |x|
      @register_user = x.register_to_use
    end
    
    @user = User.all
    @list = List.all
    @now_list = List.where(person_1: current_user.email) #현재 유저의 방정보는 person_1~4로 찾아야한다.
    
    #입력창에서 방장 / 참가자 / 구경꾼에 따라 보여주는 화면 설정
    if !@list.where(person_2: current_user.email).empty?
      @list.where(person_2: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_3: current_user.email).empty?
      @list.where(person_3: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_4: current_user.email).empty?
      @list.where(person_4: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    end
    render layout: "materialize"
  end
  
  
  def join    
    MkRoom.where(id: params[:room_num].to_i).each do |mkroom|
      if mkroom.num_of_user_join >= mkroom.num_member_limit
        mkroom.finish = true
      else
        mkroom.num_of_user_join += 1
      end
      mkroom.save
      if mkroom.finish == false
        List.where(mk_room_id: params[:room_num].to_i).each do |list| #person_# 중에 빈곳에 저장하기 위해
          if list.person_2.nil? #person_2안에 값이 비었냐
            list.person_2 = current_user.email
            list.save
          elsif list.person_2 != current_user && list.person_3.nil? #person_2에 값이 현재 유저가 아니냐 && person_3이 비었냐
            list.person_3 = current_user.email
            list.save
          elsif list.person_3 != current_user && list.person_4.nil? #person_3에 값이 현재 유저냐 && person_4가 비었냐
            list.person_4 = current_user.email
            list.save
          end
        end
        User.where(id: current_user.id).each do |user|
          user.list_id = params[:room_num]
          user.register_to_use = true
          user.save
        end
      end
    end
    
    redirect_to "/taxiple/page4"
  end
  
  def delete#방장이 방 나갔을 떄
    MkRoom.where(user_id: current_user.id).each do |mkroom|
      mkroom.destroy
    end
    
    User.where(id: current_user.id).each do |user|
      user.register_to_use = false
      user.save
    end

    List.where(mk_room_id: params[:mk_room_num]).each do |list|## @num은 MkRoom의 id를 가져오기 위함
      list.destroy
      User.where(:email => [list.person_2, list.person_3, list.person_4]).each do |x|
        x.register_to_use = false
        x.save
      # end
      # User.where(email: list.person_3).each do |x|
      #   x.register_to_use = false
      #   x.save
      # end
      # User.where(email: list.person_4).each do |x|
      #   x.register_to_use = false
      #   x.save
      end
    end
    redirect_to "/taxiple/page4"
  end
  
  def getout #참가했던 유저가 방을 나갔을 때
    @list = List.all
    if !@list.where(person_2: current_user.email).empty?
      @list.where(person_2: current_user.email).each do |list|
        @list_id = list.id
        list.person_2 = nil
        list.save
      end
    elsif !@list.where(person_3: current_user.email).empty?
      @list.where(person_3: current_user.email).each do |list|
        @list_id = list.id
        list.person_3 = nil
        list.save
      end
    elsif !@list.where(person_4: current_user.email).empty?
      @list.where(person_4: current_user.email).each do |list|
        @list_id = list.id
        list.person_4 = nil
        list.save
      end
    end
    
    User.where(list_id: @list_id).each do |user|
      user.register_to_use = false
      MkRoom.where(user_id: user.id).each do |mkroom|
        mkroom.num_of_user_join -= 1
        mkroom.save
      end
      user.save
    end
    redirect_to "/taxiple/page4"
  end
  
  
  def make_room
    #시간 설정 
    Time.zone = 'Seoul'
    @time = Time.zone.now
    
    @mkroom = MkRoom.all
    if @time.min % 5 > 0
      @minu = @time.min / 5 * 5 + 5
    else
      @minu = @time.min / 5 * 5
    end
    
    @user = User.all
    @list = List.all
    #입력창에서 방장 / 참가자 / 구경꾼에 따라 보여주는 화면 설정
    if !@list.where(person_2: current_user.email).empty?
      @list.where(person_2: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_3: current_user.email).empty?
      @list.where(person_3: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_4: current_user.email).empty?
      @list.where(person_4: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    end
    render layout: "materialize"
  end
  
  def my_room
    @mkroom = MkRoom.all
    
    @user = User.all
    @list = List.all
    #입력창에서 방장 / 참가자 / 구경꾼에 따라 보여주는 화면 설정
    if !@list.where(person_2: current_user.email).empty?
      @list.where(person_2: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_3: current_user.email).empty?
      @list.where(person_3: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    elsif !@list.where(person_4: current_user.email).empty?
      @list.where(person_4: current_user.email).each do |list|
        @p = list.mk_room_id
      end
    end
    render layout: "materialize"
  end
end
