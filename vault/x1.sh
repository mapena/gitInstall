#!/usr/bin/bash
#ansible-playbook p2.yml -v
echo sudo ansible-playbook p2.yml  --vault-password-file mypass.yml
sudo ansible-playbook p2.yml  --vault-password-file mypass.yml
