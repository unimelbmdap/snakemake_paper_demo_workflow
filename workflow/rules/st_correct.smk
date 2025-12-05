rule st_correct:
    "Runs slice-time correction"
    input:
        img="data/sub-{sub}/sub-{sub}_task-demo_run-{run}_bold.nii.gz",
    output:
        img="results/sub-{sub}/sub-{sub}_task-demo_run-{run}_st.nii.gz",
    container:
        "docker://ghcr.io/neurodesk/afni_25.2.03:20250717"
    shell:
        "3dTshift -prefix {output.img} {input.img}"
