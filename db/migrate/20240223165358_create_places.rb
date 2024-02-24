class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.integer :state
      t.string :place_reserva

      t.timestamps
    end
    add_reference :activities, :place, null: true, foreign_key: true
  end
end
