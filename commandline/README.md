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

ansible-playbook -i test site.yml -t tsv-utils
ssh puhti-login2.csc.fi (check host in inventories/test)
module use /local_scratch/<uid>/ansible/modulefiles  (check module_root in inventories/test)

# Production

In production the installation target is Kielipankki's software
environment below /appl/soft/ling/. 

ansible-playbook -i production site.yml 

# Partial installation

The roles are tagged, you can run them individually with -t. See
site.yml for details, see example in Testing above.

# Modulefiles
Note that module files are not created by all scripts, those who do have a template/module_template.j2 present.

