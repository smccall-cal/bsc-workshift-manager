class AddUserRefToPreference < ActiveRecord::Migration[5.1]
  def change
    add_reference :preferences, :user, foreign_key: true
  end
end
