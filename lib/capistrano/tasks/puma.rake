namespace :deploy do
  namespace :puma_mine do
    desc "start puma"
    task :start do
      puma_container :start
    end

    desc "reload puma"
    task :reload do
      puma_container :reload
    end

    desc "stop puma"
    task :stop do
      puma_container :stop
    end

    def start_puma_cmd
      execute "cd #{current_path}; bundle exec puma -C config/puma.rb -e production -d"
    end

    def puma_container action_name
      on roles(:app) do |host|
        puts "*" * 50
        puts "#{action_name} puma..."
        if test("[ -f #{current_path}/tmp/pids/puma.pid ]")
          puma_pid = capture("cat #{current_path}/tmp/pids/puma.pid")
          puts "puma is running"
          case action_name
          when :start
            ;;
          when :stop
            puts "stop now..."
            execute "cd #{current_path}; kill #{puma_pid}"
          when :reload
            puts "reload now..."
            execute "cd #{current_path}; kill -s USR2 #{puma_pid}"
          end
        else
          puts "puma was not started"
          case action_name
          when :start
            puts "start now..."
            start_puma_cmd
          when :stop
            ;;
          when :reload
            puts "start now..."
            start_puma_cmd
          end
          # invoke "deploy:start_puma"
        end
      end
    end
  end

end