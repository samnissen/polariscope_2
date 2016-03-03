Polariscope
===========

What is Polariscope
-------------------

Polariscope uses the Web Action API, a repository which will be released later.

Installation - Development
--------------------------

### System Dependencies


*	Ruby 2.1.5
*	MySQL 14.14

### Installation


Install the additional development package dependencies below.

For Ubuntu/Debian based distros:

	apt-get install build-essential mysql-server ruby-dev zlib1g-dev libmysqlclient-dev libsqlite3-dev git

For Red Hat/CentOs based distros:

	yum install build-essential mariadb mariadb-server ruby-devel zlib-devel mariadb-devel sqlite-devel git libyaml-devel readline-devel libffi-devel openssl-devel httpd-devel

	yum groupinstall 'Development Tools'

Install Rails:

	gem install rails

Clone repo:

	git clone https://github.com/samnissen/polariscope_2.git

Navigate into the freshly cloned repository and run:

	bundle install

### Database Initialization


Setup and configure users for MySQL database.

	CREATE USER 'polarisdev'@'localhost' IDENTIFIED BY 'polarisdev';
	GRANT ALL PRIVILEGES ON polariscope_two_dev.* TO 'polarisdev'@'localhost' WITH GRANT OPTION;
	FLUSH PRIVILEGES;

Configure environment variables for login to match. For example:

	export PSAAPPMYSQLUSERNAME='polarisdev'
	export PSAAPPMYSQLPASSWORD='polarisdev'

Configure and seed database:

	rake db:setup

### Launch Server

	rails server -e development
	RAILS_ENV=development rake all:start

Launch a worker to process jobs:

	rake jobs:work

Running Tests
-------------

TBC - Currently there is no fully functioning test suite.

Installation - Production
-------------------------
Project includes automated deployment using Mina for production environments. Dependencies are the same for Production as per the Development environment instructions above, then proceed with the instructions below for automated setup and deployment to remote host.

### Local Environment
Local machine needs to be configured with the following environment variables:

	export POLARISCOPEDEPLOYDOMAIN='<targetssh-hostname>'
	export POLARISCOPEDEPLOYTOLOCATION='<deploymentpath>'

### Remote Environment Setup - Production
The following environment variables will need to be configured within the ~/.bashrc file:

	export PSAAPPMYSQLUSERNAME='<username>'
	export PSAAPPMYSQLPASSWORD='<password>'
	export PSAAPPMYSQLSOCKETLOCATION='<host>'

	RAILS_ENV=production

Install Mina:

	gem install mina

If running deployment to a fresh environment use:

	mina setup:all

This will configure required shared paths, create MySQL database and configure a relevant user.

Finally run:

	mina deploy


### Backing up your data

The app comes with a `rake backup` task that allows you to sync your database
with another server using rsync. To take advantage of this, public-key
authentication must be setup between the two servers. And you'll need a
backup configuration in `config/backup.yml`

```yaml
backup:
  backup_file_name: polariscope.sql # Your database backup file name
  backup_file_folder: /path/to/local/folder/ # Where to save your database backup
  ssh_username: youruser # The user of the remote server
  backup_server_ip: 10.11.12.13 # The address of the remote server
  backup_server_path: /remote/machine/path/ # Where to sync the database backup to
```

This is automatically engaged when you run `rake all:start`.
Execute separately with `rake backup`. Then run a Delayed::Jobs worker.
`RAILS_ENV=production bin/delayed_job --queues=backup -i=1 start`
