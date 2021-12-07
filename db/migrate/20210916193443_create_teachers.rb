class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name, require: true
      t.integer :dni
      t.string :country
      t.string :email
      t.string :title
      t.string :phone
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
