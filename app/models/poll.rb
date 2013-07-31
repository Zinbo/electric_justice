class Poll < ActiveRecord::Base
  has_many :answers, :dependent => :destroy  
  has_many :responses, :through => :answers
  accepts_nested_attributes_for :answers
end

