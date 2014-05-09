# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  password               :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :string(255)
#  profile_pic_url        :string(255)
#  current_position_title :string(255)
#  employment_status      :string(255)
#  company_name           :string(255)
#  linkedin_profile_link  :string(255)
#  enterprise_status      :boolean          default(FALSE)
#  admin_status           :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: {minimum: 6}

  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :current_position_title, presence: true
  validates :employment_status, presence: true
  validates :company_name, presence: true

end
