# Deployment instructions

Installing the system on Ubuntu.

* Install Java 8
* Install command line utilities
* Install PROV-RIF-SPARQL harvester application
* Install and configure Apache Fuseki
* Schedule updates
* Install Provisualizer user interface
* Analytics

# Check Java is at least version 8

The Fuseki SPARQL store requires Java 8 (also known as 1.8).

Check the version of Java installed:

```bash
java -showversion
```

If the version of Java is not at least 8 (shown as "1.8"), you will need to update it.

As root, add the repository for Oracle Java 8, download the package metadata, install Java 8, and make it the default JVM.

```bash
# add-apt-repository ppa:webupd8team/java
# apt-get update
# apt-get install oracle-java8-installer
# apt-get install oracle-java8-set-default
# apt-get remove default-jre-headless
# apt-get remove openjdk-7
# ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java
```

# Install command-line utilities

The `unzip` utility will be needed to unzip the Fuseki installation package.

The `curl` utility is used to query the SPARQL store and retrieve two CSV files; one containing
descriptions of nodes in the visualization, and the other containing an adjacency matrix (i.e. edges).

To install these utilities, use the following `bash` commands:

```bash
# apt-get update
# apt-get install unzip curl
```

# Install PROV-RIF-SPARQL harvester application

Download `harvester.war` web application archive from https://github.com/Conal-Tuohy/PROV-RIF-SPARQL/releases/download/v3.0/harvester.war
and save it in the `/var/lib/tomcat7/webapps/` folder.

# Install and configure Fuseki 2 SPARQL store

Create a home folder for Fuseki configuration and data storage, and install the Fuseki configuration file.

```bash
# mkdir -p /etc/fuseki/configuration
# chown -R tomcat7:tomcat7 /etc/fuseki
```

Download the configuration file from https://raw.githubusercontent.com/Conal-Tuohy/PROV-RIF-SPARQL/master/prov.ttl and save it in the `/etc/fuseki/configuration` folder.

Download the Fuseki distribution ZIP file from http://apache.mirror.serversaustralia.com.au/jena/binaries/apache-jena-fuseki-2.3.1.zip and unzip it to find the war file.

```bash
unzip apache-jena-fuseki-2.3.1.zip
cp apache-jena-fuseki-2.3.1/fuseki.war /var/lib/tomcat7/webapps/
```

# Complete installation of the web apps

To complete installation of the Fuseki and Harvester web applications, restart Tomcat like so:

```bash
# service tomcat7 restart
```

# Install the bash scripts and SPARQL queries

Download the `scripts.zip` file from https://github.com/Conal-Tuohy/PROV-RIF-SPARQL/releases/download/v3.0/scripts.zip and install it by unzipping its contents, and scheduling two scripts using `crontab -e`, like so:

```bash
# mkdir -p /opt/provisualizer
# unzip scripts.zip -d /opt/provisualizer
# chmod a+x /opt/provisualizer/*.sh
# crontab -e
```

The `begin-harvest.sh` script should be scheduled to run at a convenient time, soon after the OAI-PMH provider's data has been updated. The harvest script will harvest data records from the OAI-PMH provider, convert them to RDF, and store them in the SPARQL store. This process may take about 40 minutes to an hour.

The `regenerate-csv.sh` script will query the SPARQL store to regenerate the CSV data files used by the PROVisualizer. For safety, allow the harvest two hours to complete, before the scheduled start of the `regenerate-csv.sh` script.

A suggested schedule for the two scripts is shown below:
```
# Start a harvest at 2am on Mondays
0 2 * * 1 /opt/provisualizer/scripts/begin-harvest.sh
# Assume harvest complete by about 2:40am, regenerate CSV files at 4am
0 4 * * 1 /opt/provisualizer/scripts/regenerate-csv.sh
```


# Install the Provisualizer user interface

Instructions for installing the Provisualizer are at https://github.com/Conal-Tuohy/Provisualizer/

Note that the regenerate-csv.sh script will generate the CSV files at the location `/var/www/html/provisualizer/data/`, so take care to install the Provisualizer in that location.

```bash
# mkdir -p /var/www/html/provisualizer
# unzip  Provisualizer-master.zip 
```

# Analytics

To track usage, you may use analytics software such as http://www.awstats.org/ to track access of the `provisualizer.js` file. This file will be accessed exactly once each time the Provisualizer is loaded in a web page in a user's browser, regardless of how many searches the user then makes inside that page.




