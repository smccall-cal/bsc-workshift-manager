class CreateSemestersShiftTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :semesters_shift_templates do |t|
      t.references :shift_template, foreign_key: true
      t.references :semester, foreign_key: true
    end
  end
end
