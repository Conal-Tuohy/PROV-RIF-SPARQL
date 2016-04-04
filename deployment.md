# Deployment instructions



Install XML Calabash
Install and configure Apache Fuseki
Install curl
Install PROV-RIF-SPARQL pipeline
Schedule updates


# Install command-line utilities

The `git` utility will be used to retrieve the PROV-RIF-SPARQL data processing pipeline from github.

The `unzip` utility will be used to unzip the Fuseki installation package.

The `curl` utility is used to query the SPARQL store and retrieve two CSV files; one containing
descriptions of nodes in the visualization, and the other containing an adjacency matrix (i.e. edges).

To install these utilities, use the following `bash` commands:

```bash
# apt-get update
# apt-get install git unzip curl
```

# Install PROV-RIF-SPARQL harvester application

Download `harvester.war` web application archive from https://github.com/Conal-Tuohy/PROV-RIF-SPARQL/releases/download/v1.0/harvester.war
and save it in `/var/lib/tomcat7/webapps/` folder.

# Install and configure Fuseki 2

Create a home folder for Fuseki configuration and data storage, and install the Fuseki configuration file.

```bash
mkdir /etc/fuseki
mkdir /etc/fuseki/configuration
```

Download the configuration file from https://raw.githubusercontent.com/Conal-Tuohy/PROV-RIF-SPARQL/master/prov.ttl and save it in the `/etc/fuseki/configuration` folder.

Download the Fuseki distribution ZIP file from http://apache.mirror.serversaustralia.com.au/jena/binaries/apache-jena-fuseki-2.3.1.zip and unzip it to find the war file.

```bash
unzip apache-jena-fuseki-2.3.1.zip
cp apache-jena-fuseki-2.3.1/fuseki.war /var/lib/tomcat7/webapps/
```

# Complete installation of web apps

To complete installation of the Fuseki and Harvester web applications, restart Tomcat like so:

```bash
# service tomcat7 restart
```

# Install the bash scripts and SPARQL queries

Download the `scripts.zip` file from TODO and install it by unzipping its contents, and scheduling two scripts using `crontab -e`, like so:

```bash
# mkdir /opt/provisualizer
# unzip scripts.zip -d /opt/provisualizer
# crontab -e
```

The `begin-harvest.sh` script should be scheduled to shortly after the OAI-PMH provider's data has been updated. The harvest script will harvest data records from the OAI-PMH provider, convert them to RDF, and store them in the SPARQL store. This process should take about 40 minutes to an hour, though the time taken will grow as the OAI-PMH dataset grows in size. 

The `regenerate-csv.sh` script will query the SPARQL store to regenerate the CSV data files used by the PROVisualizer. For safety, allow the harvest two hours to complete, before the scheduled start of the `regenerate-csv.sh` script.

A suggested schedule for the two scripts is shown below:
```
# Start a harvest at 2am on Mondays
0 2 * * 1 /opt/provisualizer/scripts/begin-harvest.sh
# Assume harvest complete by about 2:40am, regenerate CSV files at 4am
0 4 * * 1 /opt/provisualizer/scripts/regenerate-csv.sh
```







