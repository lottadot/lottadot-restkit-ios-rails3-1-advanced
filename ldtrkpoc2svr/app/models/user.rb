class User < ActiveRecord::Base
  JSON_ATTRS = ['id','username', 'email']
  def old_as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge(:user => user)
  end
  def as_json(options=nil)
    {
      :id => self.id,
      :username => self.username,
      :email => self.email
    }
  end
end
