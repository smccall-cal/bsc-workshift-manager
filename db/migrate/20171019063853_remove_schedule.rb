class RemoveSchedule < ActiveRecord::Migration[5.1]
  def change
    remove_column :preferences, :schedule
  end
end
