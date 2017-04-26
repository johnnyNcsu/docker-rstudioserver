FROM r-base:3.1.2

## Remain current

RUN apt-get update -qq && apt-get dist-upgrade -y

RUN apt-get install -y --no-install-recommends \
    gdebi-core \
    supervisor

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/suprevisord.conf
RUN wget --no-check-certificate https://download2.rstudio.org/rstudio-server-1.0.136-amd64.deb && \
    gdebi -n  rstudio-server-1.0.136-amd64.deb && \
    rm rstudio-server-1.0.136-amd64.deb

RUN useradd student \
	&& mkdir /home/student \
	&& chown student:student /home/student \
	&& addgroup student staff

COPY rstudio /etc/pam.d/rstudio

RUN Rscript -e "install.packages(c('shiny', 'ggplot2', 'corrplot', 'ggfortify', 'DT', 'treemap'))"
EXPOSE 8787
CMD ["/usr/bin/supervisord", "-n"]

LABEL org.label-schema.vendor = "ncsu-las" \
      org.label-schema.version = "0.1" \
      org.label-schema.build-date = "2017-04-05” \
      org.label-schema.docker.cmd = "docker run -td -p 8787:8787 -v=<local R workspace>:/home/student rstudioserver_student" \
      org.label-schema.url = "https://cloud.docker.com/app/ncsulas/repository/docker/ncsulas/gov/general" \
      org.label-schema.description = “R-Studio Server.” \
      org.label-schema.usage = “http://localhost:8787" \
      edu.las-ncsu.schema.version = "0.1" \
      edu.las-ncsu.schema.contact = "jgharkin@ncsu.edu" \
      edu.las-ncsu.schema.build-cmd = "docker build -t rstudioserver ."

#docker push ncsulas/gov
