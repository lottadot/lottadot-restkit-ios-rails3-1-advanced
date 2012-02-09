# http://stackoverflow.com/questions/3782177/rake-task-to-add-default-data
# RAILS_ENV="development" rake myapp:data:load
# problems? try RAILS_ENV="development" rake myapp:data:load --trace
require File.join(File.dirname(__FILE__), '../../config/environment')

namespace :myapp do
  namespace :load do

    # Swiped from ActiveRecord migrations.rb
    def announce(message)
      length = [0, 75 - message.length].max
      puts "== %s %s" % [message, "=" * length]
    end

    desc "Creates n number random topics using the Random Data gem, defaults to 150"
    task :random_topics, [:n] => :environment do |t, args|
      begin
        n = args.n.to_i < 1 ? 150 : args.n.to_i
        require 'ffaker'
        require 'random_data' 
        time = Benchmark.measure do    
          n.times do |i|
            topictitle = Faker::Company.name
            topicbody  = Faker::Lorem.paragraph
   
            catch do
             t = Topic.new(:title => topictitle, :body => topicbody)
             t.save!
              puts "%6d: %15s" % [(i+1), t.title]
            end
          end
        end
        announce "Loaded %6d topics in (%2dm %2.0fs)" % [n, *time.real.divmod(60)]      
      rescue LoadError
        puts "This rake task requires random_data.  To install, run this command:\n\n  sudo gem install random_data\n\n"
      end      
    end
  end
end
