class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :legajo
      t.string :name, require: true
      t.string :lastname, require: true
      t.date :birthdate
      t.string :country
      t.integer :dni
      t.string :email
      t.string :phone
      t.text :comment
      t.boolean :active, default: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
