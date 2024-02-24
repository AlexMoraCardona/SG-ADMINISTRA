class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.integer :state, default: 0
      t.string :observation

      t.timestamps
    end
  end
end
