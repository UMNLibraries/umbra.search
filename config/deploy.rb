# config valid only for current version of Capistrano
lock '3.10.0'

set :application, 'umbra'
set :repo_url, 'git@github.umn.edu:Libraries/umbra.git'

# to specify a specific branch when deploying:
# `BRANCH_NAME=[branch] cap production deploy`
set :branch, ENV["BRANCH_NAME"] || "master"

set :deploy_to, '/var/www/html/app'

set :pty, true

set :linked_dirs, fetch(:linked_dirs, [])

set :conditionally_migrate, true
