server '123.59.42.35', user: 'deployer', roles: %w{web app db}

set :ssh_options, {
  port: 30000
}

set :stage, :production
set :branch,  ENV['branch'] || 'master'
set :deploy_to, "/home/#{fetch(:deploy_user)}/bq"
set :rails_env, :production

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :application, 'bq'

set :enable_ssl, false
