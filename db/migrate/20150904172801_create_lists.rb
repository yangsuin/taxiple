class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.belongs_to :mk_room
      t.string :person_1
      t.string :person_2
      t.string :person_3
      t.string :person_4
      

      t.timestamps null: false
    end
  end
end
