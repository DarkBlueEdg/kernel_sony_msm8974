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
echo "export USE_CCACHE=1"
export USE_CCACHE=1
echo "*********************************************************"
echo "export LC_ALL=C"
export LC_ALL=C
echo "*********************************************************"
echo "export ARCH=arm"
export ARCH=arm
echo "*********************************************************"
echo "export CROSS_COMPILE"
export CROSS_COMPILE=/home/edgis/Desktop/EdgKernel/msm8974/prebuilts/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
echo "*********************************************************"
echo "mkdir output"
echo "*********************************************************"
mkdir output
echo "Creating Kernel & DarkBlueEdg-Log.txt"
echo "*********************************************************"
make O=output aicp_rhine_honami_row_defconfig
make -j4 O=output | tee DarkBlueEdg-Log.txt
echo "*********************************************************"
echo "zImage moving to DarkBlueEdg folder"
echo "*********************************************************"
cp output/arch/arm/boot/zImage DarkBlueEdg/tools/zImage
echo "Generating dt.img"
echo "*********************************************************"
./dtbTool -s 2048 -o output/arch/arm/boot/dt.img -p output/scripts/dtc/ output/arch/arm/boot/
echo "*********************************************************"
echo "dt.img moving to DarkBlueEdg folder"
cp output/arch/arm/boot/dt.img DarkBlueEdg/tools/dt.img
echo "*********************************************************"
echo "Zipping Kernel"
echo "*********************************************************"
cd ${path}/DarkBlueEdg
zip -r ${zip} ./
mv ${zip} ${path}
end=$(date +"%s")
sp=$(($end - $start))
echo "*********************************************************"
echo "	Finish $(($sp / 60)) minute(s) and $(($sp % 60)) seconds"
echo "*********************************************************"
