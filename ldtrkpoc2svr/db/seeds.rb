# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

lottadot = Author.create(username: 'lottadot', email:'shane@lottadot.com');
restkit_topic = Topic.create(title: 'restkit', body: 'this is the restkit topic');
lottadot_topic = Topic.create(title: 'lottadot', body: 'this is the lottadot topic');
ios_topic = Topic.create(title: 'iOS', body: 'this is the iOS topic');
objc_topic = Topic.create(title: 'objc', body: 'this is the objc topic');

restkit_post = Post.create(title: 'reskit rocks', body: 'this is the restkit post', author: lottadot);
lottadot_post = Post.create(title: 'lottadot rocks', body: 'this is the lottadot post', author: lottadot);


