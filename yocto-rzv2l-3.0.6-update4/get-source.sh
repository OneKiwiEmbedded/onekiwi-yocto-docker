#!/bin/bash

git config --global user.email "productdev@ontech.com.vn"
git config --global user.name  "OneKiwi"

git clone https://git.yoctoproject.org/git/poky
cd poky
git checkout dunfell-23.0.31
git cherry-pick eb0915c699fbe86488de172d529f073a30d05b6a
cd ../

git clone https://github.com/openembedded/meta-openembedded
cd meta-openembedded
git checkout daa4619fe3fbf8c28f342c4a7163a84a330f7653
cd ../

git clone https://git.yoctoproject.org/git/meta-gplv2
cd meta-gplv2 
git checkout 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac
cd ../

git clone https://github.com/OneKiwiEmbedded/renesas-rz-meta.git meta-renesas
cd meta-renesas
git checkout bsp-3.0.6-update4-dunfell/rzv2l
cd ../

git clone https://github.com/meta-qt5/meta-qt5.git
cd meta-qt5
git checkout -b tmp c1b0c9f546289b1592d7a895640de103723a0305
git cherry-pick 77b6060cef9337b184100083746c2e35f531be74
cd ../

git clone https://git.yoctoproject.org/git/meta-virtualization -b dunfell
cd meta-virtualization
git checkout 521459bf588435e847d981657485bae8d6f003b5
cd ../