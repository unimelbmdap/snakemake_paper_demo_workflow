rule coreg:
    "Coregisters the anatomical to the mean functional"
    input:
        anat="data/sub-{sub_num}/anat/sub-{sub_num}_T1w.nii.gz",
        func=rules.tmean.output.img,
    output:
        img="results/sub-{sub_num}/anat/sub-{sub_num}_desc-coreg_T1w.nii.gz",
    params:
        anat_stem=subpath(input.anat, strip_suffix=".nii.gz", basename=True),
    container: "docker://ghcr.io/neurodesk/afni_26.0.07:20260128"
    shadow: "shallow"
    resources: mem="4GB"
    threads: 2
    log: "logs/coreg/coreg_{sub_num}.txt"
    shell:
        """
        # run the coregistration
        align_epi_anat.py \
            -anat {input.anat} -epi {input.func} \
            -epi_base 0 -giant_move \
        &> {log}
        # convert the resulting files into NIFTI format
        3dcopy {params.anat_stem}_al+orig {output.img} &>> {log}
        """
