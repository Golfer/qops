# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'qops'
set :rails_env, 'production'

set :repo_url, 'git@bitbucket.org:Golfer/gops.git' #close repo
# set :repo_url, 'git@github.com:devtempus/qops.git' ## OLD repo

ask :branch, 'development'
# set :use_sudo, false
set :deploy_to, "/var/www/#{fetch(:application)}"

set :scm, :git

# Ruby settings
set :rvm_ruby_version, '2.3.1'
set :rvm_type, :user
set :rvm_path, '~/.rvm'

set :format, :pretty

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


set :keep_releases, 5

SSHKit.config.command_map[:rake] = "#{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Runs rake db:create'
  task create_db: [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # execute :rake, "db:create RAILS_ENV=#{fetch(:rails_env)}" PLEASE CREATE DB BEFORE DEPLOY FIRST TIME!!!!
          execute :rake, "db:migrate RAILS_ENV=#{fetch(:rails_env)}"
        end
      end
    end
  end

  before :publishing, 'deploy:create_db'
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
