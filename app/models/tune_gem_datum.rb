class TuneGemDatum < ApplicationRecord
  belongs_to :type, :foreign_key => :type_id, :primary_key => :proper_id, :class_name => "ProperName"
end
