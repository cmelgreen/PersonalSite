FROM jenkins/jenkins:latest

COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

ENV CASC_JENKINS_CONFIG=https://raw.githubusercontent.com/cmelgreen/PersonalSite/master/infrastructure-as-code/build-server/jenkins-config-as-code.yml
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

RUN /usr/local/bin/install-plugins.sh configuration-as-code git workflow-aggregator docker-plugin docker-workflow github job-dsl codedeploy