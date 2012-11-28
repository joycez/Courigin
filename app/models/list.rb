# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class List < ActiveRecord::Base
  attr_accessible :title, :description, :tag_list
  acts_as_taggable
  acts_as_commentable

  validates :title,   presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :listings, dependent: :destroy
  has_many :courses,  through: :listings

  default_scope order: 'lists.created_at DESC'

  def add!(*args)
  	course = args[0]
  	if args[1]
  	  description = args[1]
    else
      description = nil
  	end
    listings.create!(course_id: course.id, description: description)
  end

  def remove!(course)
    listings.find_by_course_id(course.id).destroy
  end

  def add_tags!(tag_list)
    self.tag_list = tag_list
    self.save
  end
end