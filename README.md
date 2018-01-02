# Camera-trap images segmentation using multi-layer robust principal component analysis
By Jhony Heriberto Giraldo Zuluaga, Augusto Salazar, Alexander Gomez, Angélica Diaz Pulido

**Abstract**: The segmentation of animals from camera-trap images is a difficult task. To illustrate, there are various challenges due to environmental conditions and hardware limitation in these images. We proposed a multi-layer robust principal component analysis (multi-layer RPCA) approach for background subtraction. Our method computes sparse and low-rank images from a weighted sum of descriptors, using color and texture features as case of study for camera-trap images segmentation. The segmentation algorithm is composed of histogram equalization or Gaussian filtering as pre-processing, and morphological filters with active contour as post-processing. The parameters of our multi-layer RPCA were optimized with an exhaustive search. The database consists of camera-trap images from the Colombian forest taken by the Instituto de Investigación de Recursos Biológicos Alexander von Humboldt. We analyzed the performance of our method in inherent and therefore challenging situations of camera-trap images. Furthermore, we compared our method with some state-of-the-art algorithms of background subtraction, where our multi-layer RPCA outperformed these other methods. Our multi-layer RPCA reached 76.17 and 69.97% of average fine-grained F-measure for color and infrared sequences, respectively. To our best knowledge, this paper is the first work proposing multi-layer RPCA and using it for camera-trap images segmentation.

See the official webpage of the paper [here](https://jhonygiraldo.wordpress.com/camera-trap-images-segmentation-using-multi-layer-robust-principal-component-analysis/)

## Citing Multi-Layer RPCA

If you find Multi-Layer RPCA useful in your research, please consider citing:

```
@article{giraldo2017camera,
  title={Camera-trap images segmentation using multi-layer robust principal component analysis},
  author={Giraldo-Zuluaga, Jhony-Heriberto and Salazar, Augusto and Gomez, Alexander and Diaz-Pulido, Ang{\'e}lica},
  journal={The Visual Computer},
  pages={1--13},
  year={2017},
  publisher={Springer}
}
```

## Database

We segmented the database with some state-of-the-art background subtraction tecniques, and our Multi-Layer RPCA. We can found the detailed results of the experiments [here](https://docs.google.com/spreadsheets/d/1oecC_VumLIM1_lHVN6igA9ZKswGwX1GpWxE4xWN-1T0/edit?usp=sharing). The Google Sheet has 7 sheets, where each sheet has the results of the experiments with each algorithm. For further details about the experiments, see the paper Camera-Trap Images Segmentation using Multi-Layer Robust Principal Component Analysis.

Our database has four knowed challenges of background subtraction. We discriminate the challenge in each sequence of our database. We can found detailed information about the challenges [here](https://docs.google.com/spreadsheets/d/1enP_xcN_hT5KpjLtm4D_KBqpws5paV7PUjiEOHU-yIM/edit?usp=sharing).

**Note**: The database is available upon request.

## Requirements: software

The script Demo.m summarizes the Experiments 1 and 2 of the paper **Camera-trap images segmentation using multi-layer robust principal component analysis**. Furthermore, we need the [LRS Library](https://github.com/andrewssobral/lrslibrary).
