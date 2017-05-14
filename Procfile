web: bundle exec puma -C config/puma.rb
work: bundle exec sidekiq -q default -q mailers
release: bundle exec rake db:migrate

