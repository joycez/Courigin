# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
  attr_accessible :body, :course_id, :title
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  belongs_to :user
  belongs_to :course
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :notifications, dependent: :destroy, as: :notifiable
  
  default_scope order: 'notes.created_at DESC' 
end
