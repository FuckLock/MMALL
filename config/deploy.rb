# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "master_rails_by_actions"
set :repo_url, "git@github.com:baodongdongCK/master_rails_by_actions.git"

# Default branch is :master
set :branch, ENV['BRANCH'] || "master"
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/opt/backend/master_rails_by_actions"
# set :deploy_to, "/var/www/my_app_name"

# capistrano-sidekiq
set :sidekiq_role, :app  
set :sidekiq_pid, "#{shared_path}/tmp/pids/sidekiq.pid"
set :sidekiq_log, "#{shared_path}/log/sidekiq.log"
set :sidekiq_env, 'production' 


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml" 
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor"
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# unicorn 部署配置
# namespace :deploy do
# 	task :restart do
# 		invoke "deploy:unicorn_mine:reload"
# 	end
# end

# after 'deploy:publishing', 'deploy:restart'

# puma 部署配置
# namespace :deploy do
# 	task :start do
# 		invoke "deploy:puma_mine:start_puma"
# 	end
# end

# after 'deploy:publishing', 'deploy:start'

# 这里使用的是capistano3-puma部署，省略了主动创建puma.rb文件
# 下面的配置会在production shared下创建puma.rb文件，这个puma文件
# 的内容就是下面的配置，如果production下puma开启了，会restart否则主动
# 开启，好处是不用自己去开PUMA了，更简单
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix:///tmp/master_app.sock"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [5, 48]
set :puma_workers, 1
set :puma_init_active_record, false
set :puma_preload_app, true
set :puma_daemonize, true

