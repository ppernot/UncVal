FROM ppernot1/shiny_base

#RUN apt-get -y --no-install-recommends install cmake

## renv
ENV RENV_VERSION 0.15.5
RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

RUN mkdir UncVal
COPY .Rprofile /UncVal/
COPY renv/activate.R /UncVal/renv/activate.R
COPY renv.lock /UncVal/renv.lock
WORKDIR /UncVal
RUN R -e 'renv::consent(TRUE)' \
 && R -e 'renv::restore()'

## app files
COPY global.R /UncVal/
COPY ui.R /UncVal/
COPY server.R /UncVal/
COPY ui_files /UncVal/ui_files/
COPY server_files /UncVal/server_files/
COPY R /UncVal/R/
COPY data /UncVal/data/

## change user from root ### BREAKS renv links !!!
#RUN addgroup --system app \
#    && adduser --system --ingroup app app
#RUN chown app:app -R /UncVal
#USER app

## expose port and run app
EXPOSE 3830
CMD ["R", "-e", "shiny::runApp(host = '0.0.0.0', port = 3830)"]
