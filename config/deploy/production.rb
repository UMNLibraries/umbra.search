# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :domain, "deploy@hub.lib.umn.edu"

role :app, "deploy@hub.lib.umn.edu"
role :web, "deploy@hub.lib.umn.edu"
role :db,  "deploy@hub.lib.umn.edu", :primary => true

set :deploy_to, '/swadm/www/aath.search'
set :use_sudo,    false

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# server 'hub.lib.umn.edu', user: 'deploy', roles: %w{web app}, :primary => true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    on roles(:app) do
      execute "#touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end

  task :stop do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart do
    on roles(:app) do
      execute "#touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end

  desc "Symlinks the extra files in the shared directory"
  task :symlink_extra do
    on roles(:app) do
      execute "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
      execute "ln -nfs #{deploy_to}/shared/config/secrets.yml #{release_path}/config/secrets.yml"
    end
  end

  before 'deploy:symlink:shared', 'deploy:symlink_extra'
end


