#!/bin/sh

echo "Start Testing"
echo "Requirements path : $1"
echo "DAGs directory : $2"
echo "Variable path : $3"
echo "Connections path : $4"

pip install -r $1

airflow db init
airflow variables import $3
airflow connections import $4

cp -r /action/* /github/workspace/

export PYTHONPATH="${PYTHONPATH:+${PYTHONPATH}:}${PWD}/$2"

pytest dag_validation.py -s -q >> result.log
pytest_exit_code=`echo Pytest exited $?`
echo $pytest_exit_code
python alert.py --log_filename=result.log --repo_token=$5
if [ "$pytest_exit_code" != "Pytest exited 0" ]; then echo "Pytest did not exit 0" ;fi
if [ "$pytest_exit_code" != "Pytest exited 0" ]; then exit 1 ;fi
