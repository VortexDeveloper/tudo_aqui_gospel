require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :rails_env, 'production'

set :domain,     '45.55.35.198'
set :deploy_to,  "/home/arthur/app/#{rails_env}"
set :app_path,   "#{deploy_to}/#{current_path}"
set :repository, 'https://github.com/VortexDeveloper/rafeek.gitruby'
set :branch,     'master'


task :environment do
  invoke :'rbenv:load'
end

task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'bundle:install'
  end
end
