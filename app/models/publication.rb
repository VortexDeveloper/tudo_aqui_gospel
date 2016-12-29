class Publication < ApplicationRecord
  belongs_to :knowledge_area
  belongs_to :author, class_name: 'User'
  has_many :pub_attachments, dependent: :destroy

  enum pub_type: [:post, :news]
  enum pub_category: [:video, :text, :mission_diary, :teology_talk, :course, :witness]

  has_attached_file(
    :image,
    styles: { normal: "800x370>", medium: "555x150>", thumb: "100x100>", min: "100x76>" },
    default_url: "../../images/banner.png"
  )

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def create_attachments(attachments)
    attachments = [attachments] unless attachments.kind_of? Array
    attachments.each do |file_params|
      p = PubAttachment.new
      p.file = file_params
      p.save!
      pub_attachments << p
    end
  end

end
