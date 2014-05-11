class CreateGadgets < ActiveRecord::Migration
  def change
    create_table(:gadgets) do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :gadgets, :user_id
  end
end
