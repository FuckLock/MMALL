# http://unicorn.bogomips.org/
# startup:
# 	unicorn_rails -E production -p 8081 -c config/unicorn.rb -D
#

# ngxin.conf
#
# user nginx;
# worker_processes 2;
# error_log /var/log/nginx/error.log;
# pid /run/nginx.pid;

# events {
#     worker_connections 1024;
# }

# http {
#     log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
#                       '$status $body_bytes_sent "$http_referer" '
#                       '"$http_user_agent" "$http_x_forwarded_for"';

#     access_log  /var/log/nginx/access.log  main;

#     sendfile            on;
#     tcp_nopush          on;
#     tcp_nodelay         on;
#     keepalive_timeout   30;
#     types_hash_max_size 2048;

#     include             /etc/nginx/mime.types;
#     default_type        application/octet-stream;


#     underscores_in_headers    on;

#     # Load modular configuration files from the /etc/nginx/conf.d directory.
#     # See http://nginx.org/en/docs/ngx_core_module.html#include
#     # for more information.
#     include /etc/nginx/conf.d/*.conf;

#     gzip  on;
#     gzip_http_version 1.1;
#     gzip_vary on;
#     gzip_comp_level 5;
#     gzip_types text/css text/html application/x-javascript application/javascript text/javascript application/json;
#     gzip_buffers 16 8k;

#     client_max_body_size 20m;

#     upstream app {
#         server localhost:3000 fail_timeout=0s;
#     }

#     server {
#        listen 80;
#        server_name doman.com;

#         error_page   500 502 503 504  /50x.html;
#         location = /50x.html {
#             root   html;
#         }

#         root /mnt/www/app/current/public;

#         # try_files will find the $uri in the given file list, if not found it will hand it to @app handler
#         try_files $uri/index.html $uri @app; 

#         location ~* \.(xml|txt|html|htm|ico|css|js|gif|jpe?g|png)(\?[0-9]+)?$ {
#             expires max;
#             try_files $uri/index.html $uri @app; 
#         }

#         location @app {
#             proxy_set_header   Host $host;
#             proxy_set_header   X-Forwarded-Host $host;
#             proxy_set_header   X-Forwarded-Server $host;
#             proxy_set_header   X-Real-IP        $remote_addr;
#             proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
#             proxy_buffering    on;
#             proxy_pass         http://app;
#        }
#     }
# }


rails_env = ENV["RAILS_ENV"] || "development"
rails_root = File.expand_path(__FILE__).split('/')[0..-3].join('/')

port_number = 5000
process_number = 1

puts "rails_root path: #{rails_root}"
puts "unicorn env: #{rails_env}"
puts "unicorn port: #{port_number}"
puts "unicorn process number: #{process_number}"

preload_app true
working_directory rails_root
pid "#{rails_root}/tmp/pids/unicorn.pid"
stderr_path "#{rails_root}/log/unicorn.log"
stdout_path "#{rails_root}/log/unicorn.log"

listen port_number, :tcp_nopush => true

# listen "/tmp/unicorn.ruby-china.sock"
worker_processes process_number
timeout 30

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = rails_root + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end