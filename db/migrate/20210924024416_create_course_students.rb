class CreateCourseStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :course_students do |t|
      t.integer :simulation_grade, :default => 0
      t.date :simulation_grade_date
      t.integer :simulation_bh_grade, :default => 0
      t.date :simulation_bh_grade_date
      t.integer :simulation_inv_grade, :default => 0
      t.date :simulation_inv_grade_date
      t.integer :final_grade, :default => 0
      t.date :final_grade_date
      t.integer :remedial_exam_note, :default => 0
      t.date :remedial_exam_note_date
      t.integer :status, :default => 0
      t.text :comment
      t.boolean :active, :default => true
      t.references :student, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
