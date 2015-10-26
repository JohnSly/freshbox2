# require "bundler/capistrano"

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'freshbox2'
set :repo_url, 'git@github.com:JohnSly/freshbox2.git'

set :scm, :git

server = '188.166.108.26'
role :web, server
role :app, server
role :db,  server, :primary => true

set :user, 'spree'
set :deploy_to, '/home/spree/#{application}'

default_run_options[:shell] = '/bin/bash --login'
default_environment["RAILS_ENV"] = 'production'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
