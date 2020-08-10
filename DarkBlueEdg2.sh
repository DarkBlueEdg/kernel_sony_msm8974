#!/bin/bash
# DarkBlueEdg © 2020
start=$(date +"%s")
path=$(pwd)
DBE=${path}/DarkBlueEdg
zip=AICP-v1.1.zip
zImage=${DBE}/tools/zImage
dt=${DBE}/tools/dt.img
output=${path}/output
txt=${path}/DarkBlueEdg-Log.txt
def=${path}/aicp_rhine_honami_row_defconfig
function clean()
{
if [ -e $1 ]
then
rm -rf $1
fi;
}
clean ${zip}
clean ${output}
clean ${dt}
clean ${zImage}
clean ${txt}
clean ${def}
echo "*********************************************************"
echo "chmod -R 777"
chmod -R 777 /home/edgis/Desktop/EdgKernel
echo "*********************************************************"
echo "make clean"
make clean
echo "*********************************************************"
echo "make mrproper"
make mrproper
echo "*********************************************************"
echo "export ARCH=arm"
export ARCH=arm
echo "*********************************************************"
echo "export CROSS_COMPILE"
export CROSS_COMPILE=/home/edgis/Desktop/EdgKernel/msm8974/prebuilts/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
echo "*********************************************************"
echo "mkdir output"
mkdir output
echo "*********************************************************"
echo "AICP menuconfig"
echo "*********************************************************"
make O=output aicp_rhine_honami_row_defconfig menuconfig
echo "*********************************************************"
echo "cd output"
echo "*********************************************************"
cd output
echo "Rename .config to aicp_rhine_honami_row_defconfig"
echo "*********************************************************"
mv .config aicp_rhine_honami_row_defconfig
echo "Moving to root folder"
mv aicp_rhine_honami_row_defconfig ${path}
end=$(date +"%s")
sp=$(($end - $start))
echo "*********************************************************"
echo "	Finish $(($sp / 60)) minute(s) and $(($sp % 60)) seconds"
echo "*********************************************************"
