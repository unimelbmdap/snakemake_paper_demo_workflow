# snakemake_paper_demo_workflow


Note that we are using Snakemake version 9.9.0 because the `threads` directive does not limit the job scheduling in current versions (see [the Github issue](https://github.com/snakemake/snakemake/issues/3815)).


Note that the AFNI container that is downloaded is quite large (3 GB).
You can use the `APPTAINER_CACHEDIR` environment variable to specify the location of this container download.
