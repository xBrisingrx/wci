# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  start_date      :date
#  finish_date     :date
#  start_hour      :time
#  finish_hour     :time
#  place           :string
#  course_level_id :integer
#  course_type_id  :integer
#  teacher_id      :integer
#  program_id      :integer
#  comment         :text
#  active          :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Course < ApplicationRecord
	belongs_to :course_level
	belongs_to :course_type
	belongs_to :program
	belongs_to :teacher
	has_many :course_students
	has_many :students, through: :course_students

	validate :dates_valids, on: :create
  validate :finish_date_valid, on: :create
  validates :course_level, presence: { message: "Debe seleccionar nivel del curso" }


	def disable
  	ActiveRecord::Base.transaction do
  		self.update(active: false)
  		students = CourseStudent.where(course_id: self.id)
  		students.update_all(active: false)

  		raise ActiveRecord::Rollback if self.id == 1
  	end

  	rescue ActiveRecord::RecordInvalid
  		errors.add(:id, "No se pudo eliminar este curso") 
  end

  def finished?
  	self.finish_date < Date.today
  end

	private 

	def dates_valids
		# fecha inicio no puede ser menor a fecha de fin
		if self.start_date > self.finish_date 
			errors.add(:start_date, 'La fecha inicio no puede ser mayor a fecha de fin')
		end
	end

	def finish_date_valid 
    # la fecha de fin no puede ser menor al dia de la fecha
    if self.finish_date < Date.today
      errors.add(:finish_date, "La fecha de fin no puede ser anterior a hoy")
    end
  end

end
