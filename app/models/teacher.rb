# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string
#  dni        :integer
#  country    :string
#  email      :string
#  title      :string
#  phone      :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Teacher < ApplicationRecord
	has_many :courses
	validates :name, presence: { message: "Este campo es obligatorio" }
	validates :dni, uniqueness: { message: "El dni pertenece a otro instructor" }, allow_blank: true
	
end
