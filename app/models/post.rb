class Post < ApplicationRecord
  validates :content, { :presence => true, :length => { :maximum => 140 } }
  validates :user_id, { :presence => true }
  validates :sora_id, { :presence => true }
  validates :review_point, { :numericality => { :greater_than_or_equal_to => 1 } }
  
  def user
    return User.find_by(:id => self.user_id)
  end
  
end
