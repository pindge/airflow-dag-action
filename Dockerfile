FROM python:3.6

ADD entrypoint.sh /entrypoint.sh

RUN pip install apache-airflow==1.10.12
RUN pip install google-cloud-storage
RUN pip install httplib2
RUN pip install google-auth-httplib2
RUN pip install google-api-python-client
RUN pip install pandas-gbq
RUN pip install jinja2-cli


#ENV AIRFLOW_HOME=/github/workspace/airflow
#ENV PYTHONPATH "${PYTHONPATH}:${AIRFLOW_HOME}"

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
