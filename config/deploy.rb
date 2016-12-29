# config valid only for current version of Capistrano
lock '3.7.1'

set :scm, :git
set :repo_url, 'git@github.com:UMNLibraries/umbra.search.git'
# to specify a specific branch when deploying:
# `BRANCH_NAME=[branch] cap production deploy`
set :branch, ENV["BRANCH_NAME"] || "master"


