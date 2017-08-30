namespace :deploy do
  namespace :puma_mine do
    desc "start puma"
    task :start do
      start_puma
    end

    def start_puma
      excute "cd #{current_path}; bundle exec puma -C config/puma.rb -e production -d"
    end
  end
end