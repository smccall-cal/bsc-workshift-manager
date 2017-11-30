class CreateShiftDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_details do |t|
      t.string :location
      t.string :description
      t.timestamps
    end
  end
end
