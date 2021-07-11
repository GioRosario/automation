# automation

How to use:
1. Simply run the runner.sh file - this pulls the list of packages, bundles them together, outputs yml and tar.gz files, and uploads to Quay.io.
2. Then run zenodo.sh file

Limitations
1. Currently cannot test individual packages.
2. Currently cannot generate a report of issues and errors in packages.
3. Cannot upload to sandbox.zenodo.org - for some reason, it can't find the site - currently working on this.
