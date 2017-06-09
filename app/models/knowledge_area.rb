class KnowledgeArea < ApplicationRecord
  has_many :columnist_knowledges, dependent: :destroy
  has_many :columnists, through: :columnist_knowledges, dependent: :destroy
end
