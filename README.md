# EdgeAI for Multi-video Analytics System Based on FPGA

This tutorial covers steps to create Machine Learning (ML) based example pipelines. It is call Single Stage Machine Learing

Single stage ML that involve only one ML operation on the input image

This tutorial begins with building a one stream, single stage Machine Learning pipeline using VVAS and then scales up to build four channel Machine learning pipelines that processes 4 streams in parallel.
 <p align="center">
            <img width="678" height="400" src="https://github.com/Advance-Innovation-Centre-AIC/EdgeAI/blob/main/Img/C07E2640-C8F0-40C9-9C4E-73BB15E313B4_1_105_c.jpeg">
   </p>
    ****By 62050104 Sabol Socare, A student in faculty of Electrical Enginering, major Electronic and Embedded System Engineering at Burapha University****

#### My Document -->   https://www.dropbox.com/scl/fi/84liong8mjdaan9gxdj71/Technical-Report-A.paper?dl=0&rlkey=y9gc3x98xrl4ce07y51ol3pg7
#### Senior project slide --> https://drive.google.com/file/d/1WQmp4HyhDJ1cY6fpo6TwDrnIv_62bGEN/view?usp=share_link
#### Cross compile AI modelzoo tutorial version 2.0 --> https://www.dropbox.com/scl/fi/njer0e24rd45wobz1hywp/Vitis-AI-Tutorial.paper?dl=0&rlkey=dshvzsb0t55ra141vci49pyfu
#### Multi-video Analytics Based on FPGA showcase 1  --> https://drive.google.com/file/d/1W48UdYRHjZynN-XeocVxFM9ldTM-IDev/view?usp=share_link
#### Multi-video Analytics Based on FPGA showcase 2 --> https://drive.google.com/file/d/11OEeyNFrHExej9BeSzDzJbjiaxPKj8nP/view?usp=share_link

## Multichannel ML
### Requirements
#### Hardware Requirements

 * ZCU104 Evaluation Board Rev 1.0
 * Micro USB cable, connected to laptop or desktop computer for the terminal emulator
 * MicroSD card, 8 GB or larger, class 10 (recommended)
 * HDMI 2.0 supported Monitor with 3840x2160 as the native resolution
 * HDMI 2.0 cable

#### Software Requirements

(Refer [Vitis Unified Software Development Platform 2022.2](https://docs.xilinx.com/r/en-US/ug1400-vitis-embedded/Installation) Documentation for installation instructions)

 * [Vitis™ Unified Software Platform](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis/2022-2.html) version 2021.2
 * [Petalinux](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools/2022-2.html) tool version 2021.2
 * Serial terminal emulator (for example, Tera Term or CoolTerm for Mac)
 * Git
 * Host system with Ubuntu 18.04/20.04 (Recommended)
 * [Balena Etcher flashing tool](https://etcher.download/)


## Build Platform

The first and foremost step is to build this platform from its sources.

The platform provides the following hardware and software components of the pipeline:

 * VCU hardened IP block
 * Video Mixer and HDMI Tx soft IP blocks
 * Opensource framework like GStreamer, OpenCV
 * Vitis AI 3.0 libraries
 * Xilinx Runtime (XRT)
 * omxh264dec GStreamer plugin
 * kmmsink GStreamer plugin 
 * VVAS GStreamer plugins and libraries
    * [vvas_xinfer](https://xilinx.github.io/VVAS/main/build/html/docs/common/gstreamer_plugins/plugin_vvas_xinfer.html#vvas-xinfer) GStreamer plugin
    * [vvas_xmetaconvert](https://xilinx.github.io/VVAS/main/build/html/docs/common/gstreamer_plugins/plugin_vvas_xmetaconvert.html#vvas-xmetaconvert) software accelerator library
    * [vvas_xoverlay](https://xilinx.github.io/VVAS/main/build/html/docs/common/gstreamer_plugins/plugin_vvas_xoverlay.html#vvas-xoverlay) software accelerator library

Steps for building the platform:

1. Download the VVAS git repository. Let the path where VVAS repo is downloaded be represented as <VVAS_REPO>.

        git clone --recurse-submodules https://github.com/Xilinx/VVAS.git

2. Setup the toolchain

        source <2022.2_Vitis>/settings64.sh
        source <2022.2_Petalinux>/settings.sh

3. Change directory to the platform

        cd <VVAS_REPO>/VVAS/vvas-platforms/Embedded/zcu104_vcuDec_vmixHdmiTx

4. Build the platform

        make 

## Board bring up

1. Burn the SD card image sd_card.img (Either from [Release package(TBD)](https://xilinx.github.io/VVAS/main/build/html/docs/Embedded/Tutorials/TBD) or generated) using a SD card flashing tool like dd, Win32DiskImager, or Balena Etcher.
 Boot the board using this SD card.
2. Once the board is booted, resize the ext4 partition to extend to full SD card size:

        resize-part /dev/mmcblk0p2

3. From the host system, copy the video files on the board:

        mkdir -p ~/videos
        scp -r <Path to Videos> root@<board ip>:~/videos

    #### You need to download videos by yourself ####

4. Copy the model json files and scripts on the board:

        scp -r <RELEASE_PATH>/vvas_multichannel_ml_2022.2_zcu104/scripts_n_utils/ root@<board ip>:~

5. Copy the Vitis-AI model files on board. Execute the command mentioned below on the target board:

        mkdir -p /usr/share/vitis_ai_library/models
        scp -r <RELEASE_PATH>/vvas_multichannel_ml_2022.2_zcu104/models/* /usr/share/vitis_ai_library/models/

6. Execute four channel GStreamer pipeline script. Execute the command mentioned below on the target board:

        cd ~/scripts_n_utils/multichannel_ml/
        ./multichannel_ml.sh

You can now see the 4-channel mixed video on the HDMI monitor.

if you want to compile model Zoo in cross platform please do it with this [Tutorial](https://www.dropbox.com/scl/fi/njer0e24rd45wobz1hywp/Vitis-AI-Tutorial.paper?dl=0&rlkey=dshvzsb0t55ra141vci49pyfu)


## Train Object Classification model using Vitis-AI 

To understand the branching and tagging strategy leveraged by this repository, please refer to [this page](https://github.com/SabolSocare/Multi-video-Analytics/tree/main/Object%20Classification)

## Retrain YOLOV5 model for detection on CPU and GPU

To uderstand this flow, please please refer to [this page](https://github.com/SabolSocare/Multi-video-Analytics/tree/main/yolov5%20)
    