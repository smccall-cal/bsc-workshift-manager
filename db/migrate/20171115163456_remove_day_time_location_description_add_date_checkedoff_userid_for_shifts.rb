class RemoveDayTimeLocationDescriptionAddDateCheckedoffUseridForShifts < ActiveRecord::Migration[5.1]
  def change
    drop_table :shifts_users
    
    change_table :shifts do |t|
      t.remove :day, :time, :location, :description, :semester_id
      t.datetime :date
      t.boolean :is_checked_off
      t.belongs_to :shift_template, index: true
      t.references :user, foreign_key: true
    end
  end
end
