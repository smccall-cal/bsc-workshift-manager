class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.belongs_to :semester, index: true
      t.string :day
      t.time :time
      t.string :location
      t.string :description
      t.timestamps
    end
  end
end
