class Poll < ActiveRecord::Base
  has_many :answers
  has_many :responses, :through => :answers
end

