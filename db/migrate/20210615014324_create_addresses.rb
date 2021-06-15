class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :cep
      t.integer :number
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
