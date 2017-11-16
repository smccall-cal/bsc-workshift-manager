class CreateSemesters < ActiveRecord::Migration[5.1]
  def change
    create_table :semesters do |t|
      t.string :semester_name
      t.datetime :start_date
      t.datetime :end_date
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end
end