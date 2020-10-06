How to run?

```
Run load test scenario script with necessary arguments:
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <USER_DATA_FILE> <pathPrefix>


e.g.

./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-identifier-freeup user-identifier-freeup_RunId 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/testdata/userData-1.csv /private/user/v1/identifier/freeup

### Note
This api works only on 30900(Learner service) ports, need to update portal details in host_multi_ips.csv file before execution
Need to pass unique user id, which are saved in a csv file during user signup api execution.
We cannot reuse same user id once mobile number/email id identifier freeup is done

