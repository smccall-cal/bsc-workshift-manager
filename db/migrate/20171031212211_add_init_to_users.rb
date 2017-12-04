class AddInitToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :init, :boolean, :default => true
  end
end
