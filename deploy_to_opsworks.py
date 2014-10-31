#!/usr/bin/env python3
import os

import boto.opsworks


def deploy(region, stack_id, app_id):
    opsworks = boto.opsworks.connect_to_region(region)
    print(opsworks.describe_stacks())
    opsworks.create_deployment(stack_id=stack_id,
                               command={'Name': 'deploy'},
                               app_id=app_id)


if __name__ == '__main__':
    deploy(region='us-east-1',
           stack_id=os.environ['OW_APP_STACK_ID'],
           app_id=os.environ['OW_APP_APP_ID'])
