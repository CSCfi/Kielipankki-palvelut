# The commandline tools of the Language Bank

This set of Ansible roles installs all relevant command line tools to either CSC's HPC environment or virtual machines

## Getting Started

Use ansible-playbook myllyPouta.yml to create VM on Pouta and install hfst on it. (still work in progress)

Use ansible-playbook -i test site.yml to create a test installation to taito-login4.csc.fi:/tmp/<username>/ansible.
Note that this will only compile, not set paths.

### Prerequisites

So far some roles only work on Taito and assume gcc/python environments on Taito.
Modulefiles need to be updated manually.

## Deployment

ansible-playbook -i production site.yml

will install everything to Taito.

## Built With

* [Ansible](https://docs.ansible.com)


## Versioning

We do not yet use [SemVer](http://semver.org/) for versioning.


## Authors

* **Martin Matthiesen** - *Initial work*
* **João daSilva**

## License

This project is not yet licensed.

## Acknowledgments

* CSC Ansible experts

