#!/bin/bash

set -ex

user_name=test-user

apt update && apt install -y git sudo locales
adduser $user_name
usermod -aG sudo $user_name
su $user_name
