class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, require: true
      t.string :cuit
      t.string :email
      t.string :country
      t.string :phone
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
