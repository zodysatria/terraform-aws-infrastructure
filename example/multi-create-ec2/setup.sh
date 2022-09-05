#!/bin/bash

yum install httpd  php -y
service httpd restart
chkconfig httpd on

cat <<EOF > /var/www/html/index.php
<?php
\$output = shell_exec('echo $HOSTNAME');
echo "<h1><center><pre>\$output</pre></center></h1>";
echo "<h1><center>Version2</center></h1>"
?>
EOF
