

set -e

DATABASE=polariscope_two
Q1="CREATE DATABASE IF NOT EXISTS $DATABASE;"
Q2="GRANT USAGE ON polariscope_two.* TO $PSAAPPMYSQLUSERNAME@localhost IDENTIFIED BY '$PSAAPPMYSQLPASSWORD';"
Q3="GRANT ALL PRIVILEGES ON polariscope_two.* TO $PSAAPPMYSQLUSERNAME@localhost;"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

mysql -uroot -p -e "$SQL"

echo "--->Done"