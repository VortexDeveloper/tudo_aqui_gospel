class ColumnistKnowledge < ApplicationRecord
  belongs_to :columnist
  belongs_to :knowledge_area
end
