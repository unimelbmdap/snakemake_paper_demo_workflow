# snakemake_paper_demo_workflow

This contains the Snakemake workflow for the paper "Orchestrating neuroimaging data processing using the 'Snakemake' workflow manager".


## Preparation

### `uv`

This is used to manage the Python environment and is installed via:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Source: [Installing uv](https://docs.astral.sh/uv/getting-started/installation/)

### Apptainer

This is used to run the software containers that are used for computation in the workflow.

To install on Ubuntu:

```bash
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt install apptainer
```

Source: [Install Ubuntu packages](https://apptainer.org/docs/admin/main/installation#install-ubuntu-packages)

### Raw data

The default expectation is that the raw data is contained within the `data` subdirectory.
See the [`snakemake_paper_demo_workflow_data`](https://github.com/unimelbmdap/snakemake_paper_demo_workflow_data) repository for a Snakemake workflow to acquire this raw data.

## Usage

To run the workflow:

```bash
uv run snakemake --cores all --use-apptainer
```

The `--dry-run` argument can also be used to see what Snakemake would execute.

## Usage notes

* We are using Snakemake version 9.9.0 because the `threads` directive does not limit the job scheduling in current versions (see [the Github issue](https://github.com/snakemake/snakemake/issues/3815)).
* The AFNI container that is downloaded is quite large (3 GB). You can use the `APPTAINER_CACHEDIR` environment variable to specify the location of this container download. The size of this container means that the (first) execution of the workflow can take a while.
