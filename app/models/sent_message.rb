class SentMessage < ActiveRecord::Base
    belongs_to :sent_sender, :class_name => 'User', :foreign_key => 'sent_sender_id'
    belongs_to :sent_recipient, :class_name => 'User', :foreign_key => 'sent_recipient_id'
    
    validates :sent_recipient, presence: true
    
end
