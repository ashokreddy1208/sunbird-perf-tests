How to run?

```
Run load test scenario script with necessary arguments:
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <DOMAIN_FILE> <USER_DATA_FILE>


e.g.

./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' sso-user-signup sso-user-signup_RunId 5 1 5 /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/testdata/tokens.csv

### Note
Generate tokens using sso-user-login script, this script will save external ids, email ids, tokens into a csv file.
Need to pass unique tokens, which are saved in a csv file.

