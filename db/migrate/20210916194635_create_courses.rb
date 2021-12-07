class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.date :start_date
      t.date :finish_date
      t.time :start_hour
      t.time :finish_hour
      t.string :place
      t.references :course_level, foreign_key: true
      t.references :course_type, foreign_key: true
      t.references :teacher, foreign_key: true
      t.references :program, foreign_key: true
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
