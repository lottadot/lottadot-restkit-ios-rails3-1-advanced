Introduction
=========================

This project is a test-example-project for an iOS iPhone app that communicates with a Ruby on Rails based backend. It uses iOS5 SDK, Ruby 1.92, Rails 3.1 and RestKit.

The goal was to create a super simple (small) iOS app that uses Storyboards and is able to pull and create objects with the website over JSON. All using RestKit and CoreData best practices.

The datamodel is inspired by Pierre Martin's questions on the [RestKit Google Group](https://groups.google.com/group/restkit):

[![](http://dl.dropbox.com/u/212730/lottadot-restkit-ios-rails3-1-advanced_datamodel_diagram.png)](http://dl.dropbox.com/u/212730/lottadot-restkit-ios-rails3-1-advanced_datamodel_diagram.png)

Bascially it is:

* topic has_many posts
* post belongs_to a topic
* post belongs_to an author
* author has_many posts

I used Restkit HEAD.

Installation
=========================

Quick Start (aka TL;DR)
-----------

(clone the repo):

* cd lottadot-restkit-ios-rails3-1-advanced

(update the git submodule that points to Restkit):

* git submodule update --init --recursive

(start the rails app in a terminal window):

* cd ldtrkpoc2svr

(if you use RVM:)
* rvm use ruby-1.9.2-p290@ldtrkpoc2svr
(If you see something like 'report_activate_error' you'll have to do 'gem install rails'. If you see something about gemset doesn't exist, then follow rvm's instructions to install the new gemset (ie rvm --create use ruby-1.9.2-p290@ldtrkpoc2svr ), and don't forget to 'gem install rails' when it's finished.)

* bundle install
* rake db:migrate
* rake db:seed
* rails s

Open a web browser and open [http://lvh.me:3000/](http://lvh.me:3000/)

Try it out
=========================
open the xcode project.
run it.

You should see 

[![](http://dl.dropbox.com/u/212730/lottadot-restkit-ios-rails3-1-advanced_screenshot.png)](http://dl.dropbox.com/u/212730/lottadot-restkit-ios-rails3-1-advanced_screenshot.png)

If you press the 'add one' button it should contact the website, create a new Topic on the website. After creating it should update the UITableView so you see the new Topic.

---
###TODO

* iOS: add code to let you cancel an attempt to add a new Topic
* iOS: re-do the TopicEditor and decouple it.
* iOS: add code to let you edit/delete a topic (which would cascade to delete it's posts)
* iOS: add code to let you create/edit/delete a new post
* website: Login/out of the website (maybe with Devise in the RoR app)
* iOS: force the user to authenticate, then when creating posts associate the user/"author" with it.

Contributing
-------------------------

Forks, patches and other feedback are always welcome. Please for it and submit a pull request.

Credits
-------------------------

* RestKit is brought to you by [Blake Watters](http://twitter.com/blakewatters) and the RestKit team.
* CoreDataTableViewController is brought to you by [Stanford CS193p Fall 2011](http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewPodcast?id=480479762)


