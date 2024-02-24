class GeneratedactivitiesToAdmCalendars < ActiveRecord::Migration[7.0]
  def change
    add_column :adm_calendars, :generatedactivities, :integer, default: 0
  end
end
