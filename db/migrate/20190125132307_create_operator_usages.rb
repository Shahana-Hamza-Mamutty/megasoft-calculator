class CreateOperatorUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :operator_usages do |t|
    	t.references :operator
    	t.date :day
    	t.integer :usage, default: 0, null: false
      t.timestamps
    end
    # Rails 5+ only: add foreign keys
    add_foreign_key :operator_usages, :operators, column: :operator_id, primary_key: :id
    add_index :operator_usages, [:operator_id, :day], unique: true
  end
end
