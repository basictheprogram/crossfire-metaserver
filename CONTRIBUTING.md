Install Visual Studio Code
Install Docker Desktop
Clone the crossfire-metaserver
Open the folder  crossfire-metaserver

VSCode should 3 docker containers
  * crossfire-metaserver-mysql
  * crossfire-metaserver-www
  * crossfire-metaserver-vscode

Populate the metserver data with test data
```
cd scripts
./curl-metaserver-port.sh
neither forward nor reverse DNS look corresponds to incoming ip address.
incoming ip: 172.20.0.4, DNS of that: crossfire-metaserver-vscode.devel
User specified hostname: localhost IP of that hostname: 127.0.0.1
```

Open your web http://localhost/meta_html.php
