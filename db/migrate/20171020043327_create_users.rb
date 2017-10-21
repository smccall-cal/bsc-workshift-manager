class CreateUsers < ActiveRecord::Migration[5.1]
    def change
        create_table :users
        add_column :users, :username, :string
        add_column :users, :hashed_pass, :string
        add_column :users, :session_id, :Integer

        add_column :users, :hours, :Integer
        add_column :users, :fines, :Integer
    end
end
