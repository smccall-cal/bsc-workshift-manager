class CreateMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :markets do |t|
      t.string :username
      t.string :shift
      t.boolean :be_taken
      t.string :taker_username
    end
  end
end
