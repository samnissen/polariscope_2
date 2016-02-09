require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'


#Basic Settings:
set :rails_env, 'production'
set :domain, ENV['POLARISCOPEDEPLOYDOMAIN']
set :deploy_to, ENV['POLARISCOPEDEPLOYTOLOCATION']
set :repository, 'git@github.com:samnissen/polariscope_2.git'
set :branch, 'master'
set :term_mode, nil #Fix for terminal hang on passphrase entry
set :keep_releases, '10' # How many releases should Mina keep on the server

#For system-wide RVM install.
set :rvm_path, '$HOME/.rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp', 'config/web_action_api.yml', 'config/secrets.yml']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
set :forward_agent, true     # SSH forward_agent.

##########################################################################
#
# Setup environment
#
##########################################################################

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
  invoke :'rvm:use[ruby-2.2]'
  set :rails_env, 'production'
end

##########################################################################
#
# Create new host tasks
# Tasks below are related to deploying a new version of the application
#
##########################################################################

task :'fresh:db' do
  queue "rake db:setup"
end

#Execute all setup tasks defined below
task :'setup:all' => :environment do
    invoke :'setup'
    queue! %[echo "-----> Setup the DB"]
    invoke :'setup:db'
    invoke :'fresh:db'
end

#Ensure that username and password variables have been correctly configured in ~/.bashrc on the remote host
desc "Create new database"
task :'setup:db' => :environment do
  queue! %{
    echo "-----> Create SQL query"
    DATABASE=polariscope_2
    Q1="CREATE DATABASE IF NOT EXISTS $DATABASE;"
    Q2="GRANT USAGE ON polariscope_2.* TO $PSAAPPMYSQLUSERNAME@localhost IDENTIFIED BY '$PSAAPPMYSQLPASSWORD';"
    Q3="GRANT ALL PRIVILEGES ON polariscope_2.* TO $PSAAPPMYSQLUSERNAME@localhost;"
    Q4="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}${Q4}"
    echo "-----> Execute SQL query to create DB and user"
    echo "-----> Enter MySQL root password on prompt below"
    #{echo_cmd %[mysql -uroot -p -e "$SQL"]}
    echo "-----> Done"
  }
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! "rvm install ruby-2.2"

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
end

##########################################################################
#
# Deployment
#
##########################################################################

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Require the domain and deploy_to variables
    # http://nadarei.co/mina/settings/
    "#{settings.domain!}"
    "#{settings.deploy_to!}"

    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    
    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
