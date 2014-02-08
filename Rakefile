task :default => [:test]

task :test do
  sh 'bundle exec rspec spec/*_spec.rb'
end

task :autotest do
  sh "fswatch . 'clear; date; bundle exec rspec spec/*_spec.rb'"
end
