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
require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
