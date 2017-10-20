class CreateUsers < ActiveRecord::Migration[5.1]
    def change
        create_table :users
        add_column :users, :username, :string
        add_column :users, :hashed_pass, :string
    end
end
