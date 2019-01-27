class CreateOperators < ActiveRecord::Migration[5.2]
  def change
    create_table :operators do |t|
      t.string :display_sign
      t.string :action
      t.string :type
      t.integer :position
      t.timestamps
    end
  end
end
