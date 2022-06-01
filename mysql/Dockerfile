ARG buildno
ARG password
ARG exporter_user
ARG exporter_passwd

RUN echo "Build number: $password"
RUN echo "Build number: $exporter_user"
RUN echo "Build number: $exporter_passwd"
RUN script-mysql_exporter.sh "$password" "${exporter_user}" "${exporter_passwd}"

