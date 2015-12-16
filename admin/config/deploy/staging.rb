server '123.59.42.35', user: 'deployer', roles: %w{web app db}

set :ssh_options, {
  port: 30000
}

set :stage, :staging
set :branch,  ENV['branch'] || 'master'
set :deploy_to, "/home/#{fetch(:deploy_user)}/core"
set :rails_env, :staging

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :application, 'core'

set :enable_ssl, false

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

after 'deploy:publishing', 'puma:restart'
