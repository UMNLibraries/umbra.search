# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :domain, "swadm@lib-umbra-prod.oit.umn.edu"

role :app, "swadm@lib-umbra-prod.oit.umn.edu"
role :web, "swadm@lib-umbra-prod.oit.umn.edu"
role :db,  "swadm@lib-umbra-prod.oit.umn.edu", :primary => true

set :deploy_to, '/swadm/var/www/html/umbra.search'
set :use_sudo,    false

append :linked_dirs, "log", "public/uploads"

set :rails_env, "production"

set :sidekiq_concurrency, 5
set :sidekiq_processes, 1

# set :branch, "maintenance"
set :branch, "refactor/thumb_cache"

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# server 'hub.lib.umn.edu', user: 'deploy', roles: %w{web app}, :primary => true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Restarts Phusion Passenger
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end