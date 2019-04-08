#!/bin/bash
cd infra &&
XELB_ADDRESS=$(terraform output elb_address)
curl -X POST \
  http://$XELB_ADDRESS/builds \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 34f53276-4b72-4567-a56b-ca57e2bb556f' \
  -H 'cache-control: no-cache' \
  -d '{
  "jobs": {
      "Build base AMI": {
          "Builds": [
            {
              "runtime_seconds": "1931",
              "build_date": "1506741166",
              "result": "SUCCESS",
              "output": "base-ami us-west-2 ami-9f0ae4e5 d1541c88258ccb3ee565fa1d2322e04cdc5a1fda"
            }, 
           {
              "runtime_seconds": "1825",
              "build_date": "1506740166",
              "result": "SUCCESS",
              "output": "base-ami us-west-2 ami-d3b92a92 3dd2e093fc75f0e903a4fd25240c89dd17c75d66"
           },
           {
              "runtime_seconds": "126",
              "build_date": "1506240166",
              "result": "FAILURE",
              "output": "base-ami us-west-2 ami-38a2b9c1 936c7725e69855f3c259c117173782f8c1e42d9a"
           },
           {
              "runtime_seconds": "1842",
              "build_date": "1506240566",
              "result": "SUCCESS",
              "output": "base-ami us-west-2 ami-91a42ed5 936c7725e69855f3c259c117173782f8c1e42d9a"
           },
           {
              "runtime_seconds": "5",
              "build_date": "1506250561",
              "result": "FAILURE",
              "output": "base-ami us-west-2 ami-34a42e15 936c7725e69855f3c259c117173782f8c1e42d9a"
           },
           {
              "runtime_seconds": "215",
              "build_date": "1506250826",
              "result": "FAILURE",
              "output": "base-ami us-west-2 ami-34a42e15 936c7725e69855f3c259c117173782f8c1e42d9a"
          }
        ]
      }
  }
}'