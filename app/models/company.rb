# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  cuit       :string
#  email      :string
#  country    :string
#  phone      :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
	has_many :students
end
