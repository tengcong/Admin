# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@bitbucket.org:_smartech/bq_scrawler.git'

set :deploy_user, 'deployer'
set :scm, :git
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# puma
# set :puma_config_file, "config/puma.rb"
set :puma_role, :app

set :puma_threads, [2, 32]
set :puma_workers, 2
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :nginx_use_ssl, false

set :linked_files, %w{config/mongoid.yml config/secrets.yml }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle }

namespace :deploy do
  after :finishing, 'deploy:cleanup'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
