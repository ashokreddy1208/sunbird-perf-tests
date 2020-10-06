#!/bin/bash

jmeterHome=$1
ips=$2
scenario_name=$3
scenario_id=$4
numThreads=$5
rampupTime=$6
ctrlLoops=$7
apiKey=$8
accessTokenUrl=$9
userName=${10}
csvFileHost=${11}
csvFileRequest=${12}
assignRoleApi=${13}

# Generating x-authenticated-token
accessToken=$(curl -s -X POST https://${accessTokenUrl}/auth/realms/sunbird/protocol/openid-connect/token  -H 'content-type: application/x-www-form-urlencoded' --data-urlencode 'client_id=mobilelogins' --data-urlencode 'grant_type=password' --data-urlencode 'client_secret=d023d75b-1983-4974-ae83-a85998e1292c' --data-urlencode 'username=${userName}' | jq -r '.access_token') # X-AUTHENTICATED-TOKEN

echo "accessToken = " ${accessToken}

JMETER_HOME=/mnt/data/benchmark/apache-jmeter-4.0
JMETER_HOME=${jmeterHome}

SCENARIO_LOGS=~/sunbird-perf-tests/sunbird-platform/logs/$scenario_name

JMETER_CLUSTER_IPS=$ips

echo "Executing $scenario_id"

if [ -f ~/logs/$scenario_id ]
then
	rm ~/logs/$scenario_id
fi

JMX_FILE_PATH=~/current_scenario/$scenario_name.jmx

mkdir $SCENARIO_LOGS
mkdir $SCENARIO_LOGS/$scenario_id
mkdir $SCENARIO_LOGS/$scenario_id/logs
mkdir $SCENARIO_LOGS/$scenario_id/server/

rm ~/current_scenario/*.jmx
cp ~/sunbird-perf-tests/sunbird-platform/$scenario_name/$scenario_name.jmx $JMX_FILE_PATH

echo "ip = " ${ips}
echo "scenario_name = " ${scenario_name}
echo "scenario_id = " ${scenario_id}
echo "numThreads = " ${numThreads}
echo "rampupTime = " ${rampupTime}
echo "ctrlLoops = " ${ctrlLoops}
echo "apiKey = " ${apiKey}
echo "accessTokenUrl = " ${accessTokenUrl}
echo "userName = " ${userName}
echo "csvFileHost = " ${csvFileHost}
echo "csvFileRequest = " ${csvFileRequest}
echo "assignRoleApi = " ${assignRoleApi}


sed "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH


sed "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#CSV_FILE#${csvFileRequest}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#PATH_PREFIX#${assignRoleApi}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH



## Copy JMX File to Logs dir ###
cp $JMX_FILE_PATH $SCENARIO_LOGS/$scenario_id/logs

echo "Running ... "
echo "$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log"

### Create HTML reports for every run ###
nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

echo "Log file ..."
echo "$SCENARIO_LOGS/$scenario_id/logs/scenario.log"

echo "Execution of $scenario_id Complete."

tail -f $SCENARIO_LOGS/$scenario_id/logs/scenario.log