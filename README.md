Polariscope
===========

What is Polariscope
-------------------

Polariscope uses the Web Action API, a repository which will be released later.

Installation - Development
--------------------------

### System Dependencies

Polariscope is optimized for

* \*nix systems, developed for stable, long term-supported operating systems
*	Ruby 2.1 or 2.2
* Rails 4.1
*	MySQL 5.5

### Installation

Install the additional development package dependencies below.

For Ubuntu/Debian based distros:

```bash
$ apt-get install build-essential mysql-server ruby-dev zlib1g-dev libmysqlclient-dev libsqlite3-dev git
```

For Red Hat/CentOs based distros:

```bash
$ yum install build-essential mariadb mariadb-server mariadb-devel ruby-devel zlib-devel sqlite-devel git libyaml-devel readline-devel libffi-devel openssl-devel
$ yum groupinstall 'Development Tools'
```

Install Rails:

```bash
$ gem install rails
```

Clone repo:

```bash
	git clone https://github.com/samnissen/polariscope_2.git
```

Navigate into the freshly cloned repository and run:

```bash
$ bundle install
```

Generate encryption key for symmetric encryption, following the guidance here:
http://rocketjob.github.io/symmetric-encryption/configuration.html.
Even if using the mina installer, be sure your install user has access to
`/etc/rails/keys/`.

### Database Initialization


Setup and configure users for MySQL database.

```sql
> CREATE USER 'polariscope-dev'@'localhost' IDENTIFIED BY 'polariscope-dev';
> GRANT ALL PRIVILEGES ON polariscope_two_dev.* TO 'polariscope-dev'@'localhost' WITH GRANT OPTION;
> FLUSH PRIVILEGES;
```

Configure environment variables for login to match. For example:

```bash
$ export PSAAPPMYSQLUSERNAME='polarisdev'
$ export PSAAPPMYSQLPASSWORD='polarisdev'
```

Configure and seed database:

```bash
$ rake db:setup
```

### Launch Server

```bash
$ rails server -e development
$ RAILS_ENV=development rake all:start
```

Launch a worker to process jobs:

```bash
$ rake jobs:work
```

Running Tests
-------------

TBC - Currently there is no fully functioning test suite.

Installation - Production
-------------------------
Project includes automated deployment using Mina for production environments. Dependencies are the same for Production as per the Development environment instructions above, then proceed with the instructions below for automated setup and deployment to remote host.

### Local Environment
Local machine needs to be configured with the following environment variables:

```bash
$ export POLARISCOPEDEPLOYDOMAIN='<targetssh-hostname>'
$ export POLARISCOPEDEPLOYTOLOCATION='<deploymentpath>'
```

### Remote Environment Setup - Production
The following environment variables will need to be configured within the ~/.bashrc file:

```bash
$ export PSAAPPMYSQLUSERNAME='<username>'
$ export PSAAPPMYSQLPASSWORD='<password>'
$ export PSAAPPMYSQLSOCKETLOCATION='<host>'

$ RAILS_ENV=production
```

Install Mina:

```bash
$ gem install mina
```

If running deployment to a fresh environment use:

```bash
$ mina setup:all
```

This will configure required shared paths, create MySQL database and configure a relevant user.

Finally run:

```bash
$ mina deploy
```

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


In addition to the `rake backup` task it is also best practice to configure an hourly local backup using cron. A recommended method of setting this up is detailed below.

Create the following hidden file:

```
"/var/crons/mysql/.database.cnf"
```

This file contains the MYSQL login details that the cronjob will use to launch mysqldump and should be formatted as per below:

```
[mysqldump]
user=mysqluser
password=mysqlpassword
```

Once saved the last step is to configure the hourly cron job as follows:

```
0 * * * * /usr/bin/mysqldump --defaults-extra-file="/var/crons/mysql/.database.cnf" polariscope_two > /home/polariscope/backup/backup.sql
```


### Database Pruning

Runs data can get large, and isn't usually useful beyond a certain time period.
Fortunately, this means we can keep our database under control.
This is done from an environment variable, set like so in `~/.bash_profile`:

```bash
$ export POLARISCOPE_ALLOWED_RUN_DATE_RANGE='6.months.ago'
```

The code must evaluate to a ActiveSupport::TimeWithZone object.
Once the date is passed by a given Run, the model prune the oldest records,
ordering by `created_at` date. If no limit is set, the pruning
will happen at 6 months. Allowed ranges include any day, week,
month or year 'ago' objects (30.days.ago, 1.year.ago, etc.).

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## Maintainer(s)

Sam Nissen - contact [here](mailto:scnissen@gmail.com) or [here](mailto:samuel.nissen@rakuten.com)
John Hulme - contact [here](mailto:john.hulme@rakuten.com)
