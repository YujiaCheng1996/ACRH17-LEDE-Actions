#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 喜大普奔 官方已默认KERNEL 5.4
#sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=5.4/g' target/linux/ipq40xx/Makefile
# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
# 获取Lienol-package
git clone https://github.com/Lienol/openwrt-package package/lienol
# 获取luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan package/diy-packages/luci-app-serverchan
# 获取koolproxyR并即时更新规则
git clone https://github.com/YujiaCheng1996/luci-app-koolproxyR package/diy-packages/luci-app-koolproxyR
pushd package/diy-packages/luci-app-koolproxyR
./koolproxyupdate.sh
popd
#=================================================
# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#=================================================
pushd package/lean
# 清除旧版argon主题并拉取最新版
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config luci-app-argon-config
popd
