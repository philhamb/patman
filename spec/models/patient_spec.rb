# == Schema Information
#
# Table name: patients
#
#  id          :integer         not null, primary key
#  f_name      :string(255)
#  s_name      :string(255)
#  dob         :date
#  email       :string(255)
#  mobile_no   :integer
#  landline_no :integer
#  occupation  :string(255)
#  interests   :string(255)
#  gender      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Patient do
  pending "add some examples to (or delete) #{__FILE__}"
end
