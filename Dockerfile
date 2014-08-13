FROM smatochkin/logstash:1.4.2

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Install Kibana content
RUN curl -Ls https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | \
    tar xz -C /opt && \
    ln -s kibana-3.1.0 /opt/kibana

# Upload Kibana configuration and startup files
ADD service /etc/service
ADD https://raw.githubusercontent.com/elasticsearch/kibana/v3.1.0/sample/nginx.conf /etc/nginx/sites-available/default
RUN sed -i -e 's%root.*%root /opt/kibana;%' /etc/nginx/sites-available/default && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    sed -i -e 's%"http://"+window.location.hostname+":9200"%""%' /opt/kibana/config.js

# Expose communication ports
EXPOSE 80
