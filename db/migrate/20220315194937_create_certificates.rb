class CreateCertificates < ActiveRecord::Migration[5.2]
  def change
    create_table :certificates do |t|
      t.date :start_date, null: false
      t.date :finish_date, null: false
      t.string :student, null: false
      t.string :teacher, null: false
      t.string :mode, null: false
      t.string :program_number, null: false
      t.string :course, null: false
      t.string :number, null: false
      t.string :path
      t.references :program, foreign_key: true
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
