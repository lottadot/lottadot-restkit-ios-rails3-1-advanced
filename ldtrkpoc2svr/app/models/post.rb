class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :author
  
  JSON_ATTRS = ['id','title','body', 'comment', 'author']
  def old_as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge(:user => user)
  end
  def as_json(options=nil)
    {
      :id => self.id,
      :title => self.title,
      :body => self.body,
      :author => self.author,
      :author_id => self.author.id,
      :topic_id => self.topic.id,
    }
  end
end
