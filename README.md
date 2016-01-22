Polariscope
===========

What is Polariscope
-------------------

Polariscope is a top-of-the-pyramid blackbox test management and execution app.

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

	yum install build-essential mysql-server ruby-devel zlib1g-devel libmysqlclient-devel libsqlite3-devel git

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
	rake all:start

Launch a worker to process jobs:
	
	rake jobs:start
