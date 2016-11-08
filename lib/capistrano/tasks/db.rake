namespace :deploy do
  namespace :db do
    task :set_rails_db_options do
      set :rails_db_options, [ ENV['VERSION'] ? "VERSION=#{ENV['VERSION']}" : nil,
                               ENV['VERBOSE'] ? "VERBOSE=#{ENV['VERBOSE']}" : nil,
                               ENV['SCOPE']   ? "SCOPE=#{ENV['SCOPE']}"     : nil,
                               ENV['STEP']    ? "STEP=#{ENV['STEP']}"       : nil ].compact
    end

    { abort_if_pending_migrations: '',
      create: '',
      drop: '',
      migrate: 'Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog).',
      rollback: 'Roll the schema back to the previous version (specify steps w/ STEP=n).',
      seed: 'Load the seed data from db/seed.rb',
      setup: 'Create the database, load the schema, and initialize with the seed data',
      reset: 'Drop and recreate the database from db/schema.rb and load the seeds',
      version: 'Retrieve the current schema version number'
    }.each do |task_name, task_desc|
      desc "Run rake db:#{task_name}".ljust(28) + task_desc
      task task_name => [:set_rails_env, :set_rails_db_options] do
        on primary fetch(:migration_role) do
          info "[deploy:db:#{task_name}] Run `rake db:#{task_name}`"
          within release_path do
            with rails_env: fetch(:rails_env) do
              execute :rake, "db:#{task_name}", *fetch(:rails_db_options)
            end
          end
        end
      end
    end

    namespace :migrate do
      { status: 'Display status of migrations',
        up: 'Run the "up" for a given migration VERSION.',
        down: 'Run the "down" for a given migration VERSION.',
        redo: 'Rollback the database one migration and re migrate up (options: STEP=x, VERSION=x).',
        reset: 'Reset your database using your migrations'
      }.each do |task_name, task_desc|
        desc "Run rake db:migrate:#{task_name}".ljust(28) + task_desc
        task task_name => [:set_rails_env, :set_rails_db_options] do
          on primary fetch(:migration_role) do
            info "[deploy:db:migrate:#{task_name}] Run `rake db:migrate:#{task_name}`"
            within release_path do
              with rails_env: fetch(:rails_env) do
                execute :rake, "db:migrate:#{task_name}", *fetch(:rails_db_options)
              end
            end
          end
        end
      end
    end
  end
end

#
# desc 'Runs rake db:create'
# task create_db: [:set_rails_env] do
#   on primary fetch(:migration_role) do
#     within release_path do
#       with rails_env: fetch(:rails_env) do
#         # execute :rake, "db:create RAILS_ENV=#{fetch(:rails_env)}" PLEASE CREATE DB BEFORE DEPLOY FIRST TIME!!!!
#         execute :rake, "db:migrate RAILS_ENV=#{fetch(:rails_env)}"
#       end
#     end
#   end
# end

# desc 'Resets DB without create/drop'
# task :reset_db do
#   on primary :db do
#     within release_path do
#       with rails_env: fetch(:stage) do
#         execute :rake, 'db:schema:load'
#         execute :rake, 'db:seed'
#       end
#     end
#   end
# end

# desc 'Upload database.yml & secret.yml'
# task :upload do
#   on roles(:all) do
#     execute "mkdir -p #{deploy_to}/shared/config"
#     upload!('config/database.yml.example', "#{deploy_to}/shared/config/database.yml")
#     upload!('config/secrets.yml.example', "#{deploy_to}/shared/config/secrets.yml")
#   end
# end