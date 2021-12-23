# == Schema Information
#
# Table name: course_levels
#
#  id         :integer          not null, primary key
#  name       :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CourseLevel < ApplicationRecord
	has_many :courses

	validates :name, presence: { message: "Este campo es obligatorio" }
	validates :name, uniqueness: { case_sensitive: false, message: "Este nivel de curso ya esta registrado" }
end
