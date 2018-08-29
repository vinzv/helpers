#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import json
import subprocess

GITHUB_ORGANIZATION = "name-of-org"
ACCESS_TOKEN="add-your-token"
CLONE_DIR="./"

r = requests.get("https://api.github.com/orgs/" + GITHUB_ORGANIZATION + "/repos?per_page=200&access_token=" + ACCESS_TOKEN)

data = json.loads(r.text)

for repo in data:
    print repo['full_name']
    p = subprocess.Popen(["git","clone", repo['clone_url']], cwd=CLONE_DIR)  
    p.wait()
