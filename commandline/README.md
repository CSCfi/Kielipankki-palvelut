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

