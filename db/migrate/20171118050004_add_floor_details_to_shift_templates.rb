class AddFloorDetailsToShiftTemplates < ActiveRecord::Migration[5.1]
  def change
    change_table :shift_templates do |t|
      t.column :floor, :string
      t.column :details, :string
    end
  end
end
