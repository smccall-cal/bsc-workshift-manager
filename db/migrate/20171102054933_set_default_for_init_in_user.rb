class SetDefaultForInitInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :init, :boolean, :default => false
  end
end
