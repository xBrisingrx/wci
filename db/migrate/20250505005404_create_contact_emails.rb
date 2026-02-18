class CreateContactEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_emails do |t|
      t.string :email
      t.string :category
      t.string :phone
      t.string :company
      t.string :course
      t.string :country
      t.string :city
      t.string :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
