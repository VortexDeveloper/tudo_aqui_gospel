class KnowledgeArea < ApplicationRecord
  has_many :columnist_knowledges
  has_many :columnists, through: :columnist_knowledges
end
