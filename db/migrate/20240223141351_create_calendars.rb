class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.integer :day, default: 1
      t.integer :month, default: 1
      t.integer :year, default: 1900
      t.string :name_day
      t.integer :day_vigente, default: 0

      t.timestamps
    end
    add_reference :calendars, :adm_calendar, null: true, foreign_key: true
  end
end
