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
require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
