class PubAttachment < ApplicationRecord
  belongs_to :publication

  has_attached_file :file
end
