rule coreg:
    "Coregisters the anatomical to the mean functional"
    input:
        anat="data/sub-{sub_num}/anat/sub-{sub_num}_T1w.nii.gz",
        func=rules.tmean.output.img,
    output:
        img="results/sub-{sub_num}/anat/sub-{sub_num}_T1w_coreg.nii.gz",
    params:
        anat_stem=subpath(input.anat, strip_suffix=".nii.gz", basename=True),
    threads: 1
    container:
        #"docker://ghcr.io/neurodesk/afni_25.2.03:20250717"
        "containers/afni.sif"
    shadow: "shallow"
    log:
        "logs/coreg/coreg_{sub_num}.txt"
    shell:
        """
        align_epi_anat.py \
            -anat {input.anat} \
            -epi {input.func} \
            -epi_base 0 \
            -giant_move \
        > {log} 2>&1
        3dcopy {params.anat_stem}_al+orig {output.img} >> {log} 2>& 1
        """

