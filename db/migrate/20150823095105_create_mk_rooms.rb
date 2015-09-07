class CreateMkRooms < ActiveRecord::Migration
  def change
    create_table :mk_rooms do |t|
      #방만들기에 필요한 요소
      t.belongs_to :user#mk_rooms가 어디에 속해있는지 알려주기위해...이것은 규칙
      t.string :course
      t.string :user_hour
      t.string :user_minute
      t.string :girl_only      
      
      #방이 완료 됐는지
      t.boolean :finish, :default => false
      #방의 인원수 관리
      t.integer :num_member_limit
      t.integer :num_of_user_join, :default => 1
      
      t.timestamps null: false
    end
  end
end
