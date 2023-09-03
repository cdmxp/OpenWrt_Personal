#!/bin/bash
#
# Copyright (c) 2019-2023 Jason6111
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/Jason6111/OpenWrt_Personal
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# v2ray_server
# sed -i s/"cp -a"/"ln -s"/g feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/api/app.lua
# sed -i s/"-config"/"run -config"/g feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/api/app.lua
# sed -i s/"xray -version"/"xray version"/g feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/api/v2ray.lua
# sed -i s/"xray -version"/"xray version"/g feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/v2ray.htm

# 日期
sed -i 's/os.date(/&"%Y-%m-%d %H:%M:%S"/' package/lean/autocore/files/x86/index.htm

# 关闭串口跑码
sed -i 's/console=tty0//g'  target/linux/x86/image/Makefile
sed -i 's/%V, %C/[Year] | by Jason /g' package/base-files/files/etc/banner
sed -i "s/Year/$(TZ=':Asia/Shanghai' date '+%Y')/g" package/base-files/files/etc/banner
sed -i '/logins./a\                                          by Jason' package/base-files/files/etc/profile

# Modify default passwd
sed -i '/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./ d' package/lean/default-settings/files/zzz-default-settings

# ID
sed -i "s/DISTRIB_REVISION='R.*.*.[0-9]/& Compiled by Jason/" package/lean/default-settings/files/zzz-default-settings

# 添加新主题  
# rm -rf ./feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./feeds/luci/themes/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config

# 主题背景
mkdir -p ./feeds/luci/themes/luci-theme-argon-mod/htdocs/luci-static/argon/background/ && curl -o ./feeds/luci/themes/luci-theme-argon-mod/htdocs/luci-static/argon/background/Network.mp4 https://raw.githubusercontent.com/Jason6111/OpenWrt_Personal/main/other/argon/video/default/Network.mp4

# 恢复主机型号
sed -i 's/(dmesg | grep .*/{a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore
#sed -i 's/(cat \/tmp.*/\{a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore
sed -i '/h=${g}.*/d' package/lean/autocore/files/x86/autocore
sed -i 's/echo $h/echo $g/g' package/lean/autocore/files/x86/autocore

# 临时
sed -i 's/5.15/6.1/g'  target/linux/x86/Makefile
#sed -i 's/73a2498dc95934c225d358707e7f7d060b5ce81aa45260ada09cbd15207d27d1/5279eb1cb7555cf9292423cc9f672dc43e6e214b3411a6df26a6a1cfa59d88b7/g' ./feeds/helloworld/ipt2socks/Makefile
#curl -o ./feeds/packages/multimedia/aliyundrive-webdav/Makefile https://raw.githubusercontent.com/coolsnowwolf/packages/aea60b5432fad984c0a4013bad0f0c5e00dcd115/multimedia/aliyundrive-webdav/Makefile
curl -o ./feeds/packages/lang/rust/Makefile https://raw.githubusercontent.com/Jason6111/OpenWrt_Personal/main/other/rust/Makefile
curl -o ./feeds/packages/lang/rust/patches/0001-Update-xz2-and-use-it-static.patch https://raw.githubusercontent.com/Jason6111/OpenWrt_Personal/main/other/rust/0001-Update-xz2-and-use-it-static.patch
#dockerman
sed -i 's/+cgroupfs-mount //g' feeds/luci/applications/luci-app-dockerman/Makefile

# zh netdata
rm -rf ./feeds/luci/applications/luci-app-netdata/
git clone https://github.com/Jason6111/luci-app-netdata ./feeds/luci/applications/luci-app-netdata/
sed -i 's/charts\.d = no/charts\.d = yes/g' ./feeds/luci/applications/luci-app-netdata/root/etc/netdata/netdata.conf
#sed -i 's/netdata\/netdata/Jason6111\/netdata/g' ./feeds/packages/admin/netdata/Makefile
#sed -i 's/20ba8695d87187787b27128ac3aab9b09aa29ca6b508c48542e0f7d50ec9322b/4845f08e39f2f2f27f07fc4676dcc69734d79e7373cb0210267227bba6cb72e0/g' ./feeds/packages/admin/netdata/Makefile

