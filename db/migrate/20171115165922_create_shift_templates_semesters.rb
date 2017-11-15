class CreateShiftTemplatesSemesters < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_templates_semesters do |t|
      t.references :shift_templates, foreign_key: true
      t.references :semesters, foreign_key: true
    end
  end
end
