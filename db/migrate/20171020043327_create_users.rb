class CreateUsers < ActiveRecord::Migration[5.1]
    def change
        create_table :users
        add_column :users, :username, :string
        add_column :users, :building, :string
        add_column :users, :role,  :string,  default: "User"
        add_column :users, :hours, :Integer, default: 0
        add_column :users, :fines, :Integer, default: 0
    end
end
