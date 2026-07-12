rule tmean:
    "Averages the motion-corrected images over time"
    input:
        imgs=lambda wildcards: collect(
            rules.mot_correct.output.img,
            sub_num=wildcards.sub_num,
            task=TASKS,
        )
    output:
        img="results/sub-{sub_num}/func/sub-{sub_num}_desc-tmean_bold.nii.gz",
    container: "docker://ghcr.io/neurodesk/afni_26.0.07:20260128",
    resources: mem="1GB"
    shadow: "shallow"
    log: "logs/tmean/tmean_{sub_num}.txt"
    shell:
        """
        # concatenate the input images over time into one output image
        # (note that the `&> {log}` redirects the screen messages to the log path)
        3dTcat -prefix tcat.nii.gz {input.imgs} &> {log}
        # average the concatenated image over time
        3dTstat -prefix {output.img} -mean tcat.nii.gz &> {log}
        """
