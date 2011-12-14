class Topic < ActiveRecord::Base
  has_many :posts
  JSON_ATTRS = ['title','body', 'comment', 'author']
  def old_as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge(:user => user)
  end
  def as_json(options=nil)
    {
      :id => self.id,
      :title => self.title,
      :body => self.body
    }
  end
end
