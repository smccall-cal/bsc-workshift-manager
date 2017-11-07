class CreateUsers < ActiveRecord::Migration[5.1]
    def change
        create_table :users
        add_column :users, :username, :string
        add_column :users, :manage, :Integer
        add_column :users, :hours, :Integer, default: 0
        add_column :users, :fines, :Integer, default: 0
    end
end
