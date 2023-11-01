aalto-asr
=====

Installing Aalto's singularity based speech recognizer

# Install for local testing as unpriviledged user

`cd Kielipankki-palvelut/commandline`

Install as normal user to puhti-login12:
`ansible-playbook site.yml -vv -i inventories/test_csc -t aalto-asr`

Login to puhti-login12.csc.fi:
`ssh puhti-login12.csc.fi`

Add your local module to the module system:
`module use /local_scratch/<your used id>/ansible/modulefiles/`

Load the module by version number:
`module load aalto-asr/<version>`

Note that your private module is considered now before the official one with the same version number!
To revert, use `module unuse /local_scratch/<your user id>/ansible/modulefiles/`
