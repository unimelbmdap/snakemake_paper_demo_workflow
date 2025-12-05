
import pathlib

import numpy as np

import nibabel


def run() -> None:

    rand = np.random.default_rng(seed=1)

    data = rand.random(size=(64, 64, 16, 10))

    nii = nibabel.Nifti1Image(dataobj=data, affine=np.eye(4))

    for sub_num in [1, 2]:
        output_dir = pathlib.Path(f"data/sub-{sub_num:02d}/")
        output_dir.mkdir(exist_ok=True, parents=True)
        for run_num in [1, 2, 3]:
            output_path = (
                output_dir
                / f"sub-{sub_num:02d}_task-demo_run-{run_num:02d}_bold.nii.gz"
            )
            nibabel.save(img=nii, filename=output_path)


if __name__ == "__main__":
    run()
