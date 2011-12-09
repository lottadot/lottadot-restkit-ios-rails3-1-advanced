class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :author
end
