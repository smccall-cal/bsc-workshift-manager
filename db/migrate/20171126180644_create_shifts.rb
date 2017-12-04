class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
        t.datetime :date
        t.boolean :is_checked_off
        t.integer :checked_off_by

        t.belongs_to :shift_template, index: true
        t.references :user, foreign_key: true
        t.timestamps
    end
  end
end
