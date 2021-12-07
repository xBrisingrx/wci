# == Schema Information
#
# Table name: course_students
#
#  id                        :integer          not null, primary key
#  simulation_grade          :integer          default(0)
#  simulation_grade_date     :date
#  simulation_bh_grade       :integer          default(0)
#  simulation_bh_grade_date  :date
#  simulation_inv_grade      :integer          default(0)
#  simulation_inv_grade_date :date
#  final_grade               :integer          default(0)
#  final_grade_date          :date
#  remedial_exam_note        :integer          default(0)
#  remedial_exam_note_date   :date
#  status                    :integer          default("pending")
#  comment                   :text
#  active                    :boolean          default(TRUE)
#  student_id                :integer
#  course_id                 :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class CourseStudent < ApplicationRecord
  belongs_to :student
  belongs_to :course
  # belongs_to :remedial_course, class_name:  :Course, :foreign_key => 'remedial_course', optional: true

  enum status: [:pending, :pass, :no_pass, :absent]
  # singleton_class.undef_method :open # hide Kernel.open, avoiding a warning when defining scope :open
  # scope :open, -> { where(status: [:pending, :pass, :fail]) }


  validates :final_grade_date, presence: { message: 'Debe ingresar la fecha'}, if: :final_grade_changed?, on: :update 
  validates :remedial_exam_note_date, presence: { message: 'Debe ingresar la fecha'}, if: :remedial_exam_note_changed?, on: :update 

  validate :estudiante_repetido, on: :create
  # validate :course_ended, on: :create 


  private
  def estudiante_repetido
    # un alumno no puede estar mas de una vez en el mismo curso
    student = CourseStudent.where(course_id: self.course_id, student_id: self.student_id)
    #if !student.nil?
    if !(student.count == 0)
      errors.add(:student_id, "Este alumno ya se encuentra registrado en este curso")
    end
  end

  def course_ended 
    # si el curso ya termino no podemos agregar alumnos 
    course = Course.find(self.course_id)
    if course.finish_date < Time.now
      puts "fechita #{course.finish_date}"
      errors.add(:student_id, "Este curso ya ha finalizado, no se pueden registrar alumnos")
    end
  end

  def check_date
    if self.final_grade_changed? && !self.final_grade_changed_date?
      errors.add(:final_grade_date, "Este curso ya ha finalizado, no se pueden registrar alumnos")
    end
  end

end
