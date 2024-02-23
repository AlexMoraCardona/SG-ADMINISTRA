class CreateLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :levels do |t|
      t.integer :state, default: 0
      t.integer :level_user, default: 0
      t.integer :restriction, default: 0
      t.integer :restriction_count, default: 0

      t.timestamps
    end
    add_reference :users, :level, null: true, foreign_key: true
  end
end
