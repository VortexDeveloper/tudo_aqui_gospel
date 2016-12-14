class Publication < ApplicationRecord
  belongs_to :knowledge_area
  belongs_to :author, class_name: 'User'
  has_many :pub_attachments

  enum pub_type: [:post, :news]
  enum pub_category: [:video, :text, :mission_diary, :teology_talk, :course, :witness]
end
