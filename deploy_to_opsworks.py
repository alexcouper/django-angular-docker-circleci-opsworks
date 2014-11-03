#!/usr/bin/env python3
import argparse
import os

import boto.opsworks


def deploy(region, stack_id, app_id):
    opsworks = boto.opsworks.connect_to_region(region)
    opsworks.create_deployment(stack_id=stack_id,
                               command={'Name': 'deploy'},
                               app_id=app_id)


if __name__ == '__main__':
    parser = argparse.ArgumentParser('AWS OpsWorks deployment script')
    parser.add_argument('type',
                        help='The type of deployment (currently only "app")')
    args = parser.parse_args()

    deploy_kwargs = {'region': 'us-east-1'}
    if args.type == 'app':
        deploy_kwargs.update({
            'stack_id': os.environ['OW_APP_STACK_ID'],
            'app_id': os.environ['OW_APP_APP_ID']})
    elif args.type == 'static':
        deploy_kwargs.update({
            'stack_id': os.environ['OW_STATIC_STACK_ID'],
            'app_id': os.environ['OW_STATIC_APP_ID']})
    else:
        raise ValueError(args.type)

    deploy(**deploy_kwargs)
