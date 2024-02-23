class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nro_document
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :state
      t.string :phone

      t.timestamps
    end
    add_index :users, :nro_document, unique: true
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
