class Comment < ActiveRecord::Base

  belongs_to :plays
  belongs_to :author, class_name: 'User'

end
