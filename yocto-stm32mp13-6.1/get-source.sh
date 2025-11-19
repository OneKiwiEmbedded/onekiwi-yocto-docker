#!/bin/bash

git config --global user.email "productdev@ontech.com.vn"
git config --global user.name  "OneKiwi"

repo init -u https://github.com/OneKiwiEmbedded/stm32mp-manifest -b mickledore -m mp13-mickledore-mp1-v24.03.13.xml
repo sync