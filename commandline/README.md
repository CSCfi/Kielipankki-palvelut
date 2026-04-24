# The Language Bank Tool portfolio

This script installs the following tools to HPC:

 * hfst
 * hfst-morphologies
 * check-hfst
 * praat
 * udpipe
 * enchan
 * opensmile
 * trankit
 * heliots
 * vrt-tools
 * tsv-utils
 * finnish-tagtools

See site.yml for details, to generate the list above use `egrep -o "tags: [^ ]+ " site.yml |sed 's/tags:/ \*/'`
the names above represent the tag names in the ansible file.

# Testing

In testing mode the script "installs" the tools to a temporary directory, see inventories/test for details. To selectively install, use tags, e.g.:
```
ansible-playbook -i inventories/test_csc site.yml -t tsv-utils
ssh puhti-login12.csc.fi  # (check host in inventories/test_csc)
module use /local_scratch/<uid>/ansible/modulefiles  # (check module_root in inventories/test)
```

## Local installation

It is possible to install the tools on a local machine to test the
scripts, but this still needs some manual work. With these
instructions, it is possible to run most of the site.yml on a local
Ubuntu machine.


Known issues

- PATH variable not properly set
- HFST python bindings do not compile
- trankit does not install, for options see https://trankit.readthedocs.io/en/latest/installation.html 
- enchant needs to be installed via `apt install enchant-2  libenchant-2-voikko voikko-fi hunspell-sv`
- finnish-tagtools check fails
- finnish-tagtools issues harmless syntax warnings in python 3.10+


Below are the steps needed:

```
# create directory that corresponds to install_prefix
sudo mkdir /data
sudo chown <your user id> /data

# debian dependencies for hfst
sudo apt install libxml++2.6-dev libarchive-dev autoconf libtool libreadline-dev swig python3-dev
pip install setuptools
# some alternatives for other systems
libxml++2 libarchive

# the hfst and tagtools installation locations must be in path so that is discovered when testing finnish-tagtools
export PATH="/data/hfst/3.16.0/bin:/data/finnish-tagtools/1.6.0/bin:$PATH"

# run the playbook locally
ansible-playbook site.yml -i inventories/localhost
```

A long term solution is to adjust the roles and/or the invocation (e.g. use of `is_admin`) to make these extra steps unnecessary.

# Production

In production the installation target is Kielipankki's software
environment on CSC's supercomputer(s).

ansible-playbook -i inventories/production site.yml

# Partial installation

The roles are tagged, you can run them individually with -t. See
site.yml for details, see example in Testing above.
