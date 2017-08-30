environment "production"
threads 4,48
workers 1

basedir = "/opt/backend/master_rails_by_actions"
bind  "unix:///tmp/master_app.sock"
pidfile  "#{basedir}/current/tmp/pids/puma.pid"
state_path "#{basedir}/current/tmp/pids/puma.state"
stdout_redirect "#{basedir}/shared/log/puma.stdout.log", "#{basedir}/shared/log/puma.stderr.log", true
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
