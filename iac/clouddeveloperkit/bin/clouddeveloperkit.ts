#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { ClouddeveloperkitStack } from '../lib/clouddeveloperkit-stack';

const app = new cdk.App();
new ClouddeveloperkitStack(app, 'ClouddeveloperkitStack');
