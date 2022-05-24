# The Language Bank Tool portfolio

This script installs the following tools to Taito:

 * HFST
 * The HFST Morphologies for several languages
 * HFST Ospell
 * finnish-parse, based on the Turku Dependency Parser
 * ffmpeg
 * libxml2, xslt1
 * kaldi

# Defaults

The tools are installed via /tmp on taito-login4. /tmp is fast, but only visible locally, therefore the machine name had to be fixed.

# Testing

In testing mode the script "installs" the tools to
/tmp/<username>/ansible/install/. target_host needs to be specified to
remind that installs are targeted at Taito.

ansible-playbook -i test site.yml -e "target_host=taito"

## Local installation

It is possible to install the tools on a local machine to test the scripts, but this still needs some manual work. With these instructions, it is possible to run most of the site.yml on a local Ubuntu machine: finnish-parse must be skipped due to its installation script being outdated, and at least on a virtual machine with frugal amount of memory, kaldi compilation will not succeed.

Below are the steps needed:

```
# create directory that corresponds to install_prefix
sudo mkdir /data
sudo chmod 0777 /data

# debian dependencies for hfst
sudo apt install libxml++2.6-dev libarchive-dev autoconf libtool libreadline-dev swig
# some alternatives for other systems
libxml++2 libarchive

# dependencies for finnish-parse
sudo apt install opennlp

# the hfst and tagtools installation locations must be in path so that is discovered when testing finnish-tagtools
export PATH="/data/ling/hfst/3.16.0/bin:/data/ling/finnish-tagtools/1.6.0/bin:$PATH"

# run the playbook locally (set python version to match yours)
ansible-playbook site.yml -i inventories/localhost --connection=local --extra-vars "python3_base_version=3.8"
```

A long term solution is to adjust the roles and/or the invocation (e.g. use of `is_admin`) to make these extra steps unnecessary.

# Production

In production the installation target is Kielipankki's software
environment below /appl/ling/. The ling user needs to accept your
certificate for passwordless login.

ansible-playbook -i production site.yml -e "target_host=taito"

# Partial installation

The roles are tagged, you can run them individually with -t. See
site.yml for details. 

# Modulefiles
Note that module files are not created by these scripts.

