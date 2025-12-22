rule tmean:
    "Averages the motion-corrected images over time"
    input:
        imgs=lambda wildcards: collect(
            rules.mot_correct.output.img,
            sub_num=wildcards.sub_num,
            task=TASKS,
        )
    output:
        img="results/sub-{sub_num}/func/sub-{sub_num}_mean.nii.gz",
    container:
        #"docker://ghcr.io/neurodesk/afni_25.2.03:20250717"
        "containers/afni.sif"
    shadow: "shallow"
    log:
        "logs/tmean/tmean_{sub_num}.txt"
    shell:
        """
        3dTcat -prefix tcat.nii.gz {input.imgs} > {log} 2>&1
        3dTstat -prefix {output.img} -mean tcat.nii.gz > {log} 2>&1
        """

