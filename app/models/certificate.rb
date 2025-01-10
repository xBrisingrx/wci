class Certificate < ApplicationRecord
	belongs_to :program

	validates :student, presence: { message: "Este campo es obligatorio" }
	validates :dni, presence: { message: "Este campo es obligatorio" }
	# validates :dni, numericality: { message: "Se deben ingresar solo numeros" }
	validates :teacher, presence: { message: "Este campo es obligatorio" }
	validates :start_date, presence: { message: "Este campo es obligatorio" }
end