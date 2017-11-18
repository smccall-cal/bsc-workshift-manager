class CreateShiftTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_templates do |t|
      t.integer :hours
      t.string :day
      t.references :shift_detail, foreign_key: true
      t.timestamps
    end
  end
end
