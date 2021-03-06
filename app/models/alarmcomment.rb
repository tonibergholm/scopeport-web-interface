class Alarmcomment < ActiveRecord::Base
	validates_presence_of :comment
  validates_numericality_of :alarm_id, :user_id

  belongs_to :user
  
  named_scope :recent, lambda { |time|  { :conditions => ["created_at > ?", time ] } }
end
