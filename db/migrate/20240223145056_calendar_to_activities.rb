class CalendarToActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :squares do |t|
      t.string :name
      t.string :address
      t.integer :state, default: 0

      t.timestamps
    end

    add_reference :activities, :user, null: true, foreign_key: true
    add_reference :activities, :calendar, null: true, foreign_key: true
    add_reference :activities, :square, null: true, foreign_key: true

  end
end
