class Answer < ActiveRecord::Base
  belongs_to :poll
  has_many :responses
end
