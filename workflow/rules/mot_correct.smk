rule mot_correct:
    "Runs motion correction"
    input:
        img="data/sub-{sub_num}/func/sub-{sub_num}_task-{task}_bold.nii.gz",
        base="data/sub-{sub_num}/func/sub-{sub_num}_task-stopsignal_bold.nii.gz",
    output:
        img="results/sub-{sub_num}/func/sub-{sub_num}_task-{task}_desc-mc_bold.nii.gz",
    params:
        base_volume=0,
    resources: mem="1GB"
    container: "docker://ghcr.io/neurodesk/afni_26.0.07:20260128"
    log: "logs/mot_correct/mot_correct_{sub_num}_{task}.txt"
    script: "../scripts/mot_correct.py"
