task :default => [:test]

task :test do
  sh 'bundle exec rspec `find spec -name \*_spec.rb`'
end

task :autotest do
  sh "fswatch . 'clear; date; bundle exec rspec `find spec -name \*_spec.rb`'"
end
