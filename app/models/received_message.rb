class ReceivedMessage < ActiveRecord::Base
    belongs_to :received_sender, :class_name => 'User', :foreign_key => 'received_sender_id'
    belongs_to :received_recipient, :class_name => 'User', :foreign_key => 'received_recipient_id'
    
end
