class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.string :code, require: true
      t.string :name, require: true
      t.integer :certificate, required: true
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
