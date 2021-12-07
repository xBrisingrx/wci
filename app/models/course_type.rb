# == Schema Information
#
# Table name: course_types
#
#  id         :integer          not null, primary key
#  name       :string
#  comment    :text
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CourseType < ApplicationRecord
	has_many :courses
end
