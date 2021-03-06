class Servicecomment < ActiveRecord::Base
  validates_presence_of :comment
  validates_numericality_of :service_id, :user_id

  belongs_to :user
  
  named_scope :recent, lambda { |time|  { :conditions => ["created_at > ?", time ] } }

end
