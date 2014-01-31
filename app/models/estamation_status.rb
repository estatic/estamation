class EstamationStatus < ActiveRecord::Base
  unloadable
  has_many :estamations
  
  def to_s
      return self.title
  end
end
