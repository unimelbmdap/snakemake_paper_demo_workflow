rule mot_correct:
    "Runs motion correction"
    input:
        img="data/sub-{sub_num}/func/sub-{sub_num}_task-{task}_bold.nii.gz",
    output:
        img="results/sub-{sub_num}/func/sub-{sub_num}_task-{task}_mc.nii.gz",
    params:
        base="data/sub-{sub_num}/func/sub-{sub_num}_task-stopsignal_bold.nii.gz[0]",
    container:
        #"docker://ghcr.io/neurodesk/afni_25.2.03:20250717"
        "containers/afni.sif"
    log:
        "logs/mot_correct/mot_correct_{sub_num}_{task}.txt"
    shell:
        """
        3dvolreg -base {params.base} -prefix {output.img} {input.img} > {log} 2>&1
        """

