class CreatePolicies < ActiveRecord::Migration[5.1]
  def change
    create_table :policies do |t|

      t.timestamps
      t.string :filename
    end
  end
end
