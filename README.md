# ELK server in Docker

## Components

* Kibana 3.1.0
* Nginx
* Logstash server 1.4.2
* ElasticSearch server 1.1.1
* Oracle Java 7
* Ubuntu 14.04 Trusty

## Resources

* Kibana/Nginx http server dashboard with ES proxy
** 80/tcp
* Logstash ports implemented syslog input
** 5000/tcp
** 5000/udp
* ElasticSearch volume `/data/elasticsearch` containing `data` and `log` directories
* ElasticSearch ports
** 9300/tcp (transport)
** 9200/tcp (HTTP)

## Usage

Instantiate Docker container

```
docker run -d -p :5000 -p :80 smatochkin/kibana
```

Find public port numbers for syslog input and dashboard access

```
docker inspect -f 'Dashboard port: {{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' $(docker ps -ql)
docker inspect -f 'Logsink port:   {{(index (index .NetworkSettings.Ports "5000/tcp") 0).HostPort}}' $(docker ps -ql)
```
