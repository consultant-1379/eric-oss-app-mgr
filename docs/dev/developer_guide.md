# General information about how to run the test scripts

This directory contains development scripts, used to help run the various test suites locally on your development
environment.

## Steps for running ipv4 test suite locally

Note: It is recommended to clone the repo using Ubuntu terminal.

**Step 1: Find the correct directory path:**
The below path will be applicable only on UNIX machine.

```bash
cd <path_to_the_directory_where_you_have_cloned_the_repo>
```

The below path will be applicable for Windows Subsystem for Linux (WSL).

```bash
cd /mnt/c/<project_working_directory>/eo-integration-charts/dev

# OR - If c drive is already mounted as part of ~/.bashrc configuration, use the following:

cd /c/<project_working_directory>/eo-integration-charts/dev
```

**Step 2: Execute the below command to run the test:**

```bash
./dev/<test_script_name>.sh
```

**Test script description:**

- run_helm_chart_validator.sh: Executes the helm chart static checks including openshift static test as well.

## Steps for running ipv6 test suite locally

To run the ipv6 test suite locally, it is required to update the settings in the Docker Desktop.

**Step 1: Go to the Docker Desktop settings:**
Select Docker Engine and add the below lines after this statement "experimental":false.

```bash
"ipv6": true,
"fixed-cidr-v6": "2001:db8:1::/64"
```

Then click Apply & Restart

**Step 2: Follow the Step 1 and Step 2 from ipv4 test suite:**
