# docker-rstudioserver
## Description
Build and support files for creating a docker image to host R Studio Server.
## Build
    docker build -t rstudioserver .
## Execute
    docker run -td -p 8787:8787 -v=<local R workspace>:/home/student rstudioserver_student
## Usage
    http://localhost:8787
    Login: student
    Password: any character
## Support Files
* rstudio
 * This is the PAM configuration file for the server; it is copied to the image as follows:

        COPY rstudio /etc/pam.d/rstudio
* sysconfig
 * This is the configuration file for sysconfig.d; it is copied into the image as follows:

        COPY supervisord.conf /etc/supervisor/conf.d/suprevisord.conf
