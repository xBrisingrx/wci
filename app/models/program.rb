# == Schema Information
#
# Table name: programs
#
#  id          :integer          not null, primary key
#  code        :string
#  name        :string
#  certificate :integer
#  comment     :text
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Program < ApplicationRecord
	has_many :courses 
	
	validates :code, presence: { case_sensitive: false, message: "Este campo es obligatorio" }
	validates :code, uniqueness: { message: "Este codigo pertenece a otro programa" }
	validates :name, presence: { case_sensitive: false, message: "Este campo es obligatorio" }
	validates :name, uniqueness: { message: "Este nombre pertenece a otro programa" }
end
