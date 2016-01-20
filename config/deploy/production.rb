server '124.42.117.148', user: 'deployer', roles: %w{web app db}

set :stage, :production
set :branch, 'master'
set :deploy_to, "/home/#{fetch(:deploy_user)}/vr"
set :rails_env, :production

set :rbenv_type, :user
set :rbenv_ruby, '2.2.4'
set :application, 'vr'

set :enable_ssl, false

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

after 'deploy:publishing', 'puma:restart'

