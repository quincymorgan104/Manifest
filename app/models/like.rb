class Like < ActiveRecord::Base
  belongs_to :mfst
  belongs_to :user
end