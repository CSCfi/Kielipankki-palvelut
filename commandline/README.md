# The Language Bank Tool portfolio

This script installs tools to HPC, like:

 * HFST
 * The HFST Morphologies for several languages
 * HFST Ospell
 * finnish-parse, based on the Turku Dependency Parser
 * ffmpeg
 * libxml2, xslt1
 * kaldi

See site.yml for details.

# Testing

In testing mode the script "installs" the tools to a temporary directory, see inventories/test for details. To selectively install, use tags, e.g.:

ansible-playbook -i inventories/csc_test site.yml -t tsv-utils
ssh puhti-login2.csc.fi (check host in inventories/test)
module use /local_scratch/<uid>/ansible/modulefiles  (check module_root in inventories/test)

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
environment below /appl/soft/ling/.

ansible-playbook -i inventories/production site.yml

# Partial installation

The roles are tagged, you can run them individually with -t. See
site.yml for details, see example in Testing above.

# Modulefiles
Note that module files are not created by all scripts, those who do have a template/module_template.j2 present.
