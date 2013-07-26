class User < ActiveRecord::Base
  
  has_many :characters
  
  has_many :received_messages_as_sender, :class_name => "ReceivedMessage", :foreign_key => 'received_sender_id'
  has_many :received_messages_as_recipient, :class_name => "ReceivedMessage", :foreign_key => 'received_recipient_id'
  
  has_many :sent_messages_as_sender, :class_name => "SentMessage", :foreign_key => 'sent_sender_id'
  has_many :sent_messages_as_recipient, :class_name => "SentMessage", :foreign_key => 'sent_recipient_id'
  
  accepts_nested_attributes_for :characters
  
  before_save { self.email = email.downcase }
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :database_authenticatable, 
         :recoverable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin
  # attr_accessible :title, :body
  
  def to_s
    Character.find_by_user_id_and_primary(self.id, true).name
  end
  
end
