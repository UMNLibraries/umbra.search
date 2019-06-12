# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'umbra'
set :repo_url, 'git@github.umn.edu:Libraries/umbra.git'

# to specify a specific branch when deploying:
# `BRANCH_NAME=[branch] cap production deploy`
set :branch, ENV["BRANCH_NAME"] || "master"

set :default_environment, {
  'PATH' => "/swadm/bin/ruby:$PATH"
}

set :pty, true

set :linked_dirs, fetch(:linked_dirs, [])

append :linked_dirs, "log", "public/uploads", "tmp/pids"

set :conditionally_migrate, true

set :passenger_restart_with_touch, true

# Restart all sidekiq instances so they can pick up the new code
namespace :deploy do
  after :finishing, :notify do
    invoke "deploy:restart_sidekiq"
  end

  task :restart_sidekiq do
    on roles(:all) do |host|
      (0..1).map do |pid|
        execute "sudo systemctl restart sidekiq-#{pid}"
      end
    end
  end
end