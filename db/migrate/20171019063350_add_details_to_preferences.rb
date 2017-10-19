class AddDetailsToPreferences < ActiveRecord::Migration[5.1]
  def change
    add_column :preferences, :shift, :string
    add_column :preferences, :schedule, :string
  end
end
