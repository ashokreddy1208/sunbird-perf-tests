How to run?

```
Run load test scenario script with necessary arguments:
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <USER_DATA_FILE> <pathPrefix>


e.g.

./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' ext-user-create ext-user-create_RunId 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/testdata/user-create-test-data.csv /api/user/v3/create

### Command to generate test data
Script to generate test data required to create user

./generate-test-data.sh 60 60 60 0

This will create test data with 60 users with file name user-create-test-data.csv 

### Sample CSV Data

|firstName|extid|email|
|---|---|---|---|
|1556528849-1|1556528849-1|1556528849-1@domain.com|
|1556528849-2|1556528849-2|1556528849-2@domain.com|