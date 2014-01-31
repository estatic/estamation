class EstamationGroup < ActiveRecord::Base
  unloadable
  has_and_belongs_to_many :estamations
end
