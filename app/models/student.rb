# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  legajo     :string
#  name       :string
#  lastname   :string
#  birthdate  :date
#  country    :string
#  dni        :integer
#  email      :string
#  phone      :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < ApplicationRecord
	belongs_to :company
	has_many :course_students
	has_many :courses, through: :course_students

	validates :name, presence: { message: "Este campo es obligatorio" }
	validates :lastname, presence: { message: "Este campo es obligatorio" }
	# No se pueden repetir los legajos dentro de una misma empresa
	validates :legajo, uniqueness: { scope: :company_id ,case_sensitive: false, message: "Ya existe un alumno con este legajo en esta empresa" }, allow_blank: true
	validates :dni, uniqueness: { message: "El dni pertenece a otro alumno" }, allow_blank: true

	def fullname
		"#{self.name} #{self.lastname}"	
	end

end
