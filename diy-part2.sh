#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/Cudy-Tr3000/g' package/base-files/files/bin/config_generate

# Enable USB power for Cudy TR3000 by default
sed -i '/modem-power/,/};/{s/gpio-export,output = <1>;/gpio-export,output = <0>;/}' target/linux/mediatek/dts/mt7981b-cudy-tr3000-v1.dtsi

# Set timezon and ntp server
sed -i 's/0.openwrt.pool.ntp.org/ntp.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/ntp2.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/ntp3.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/UTC/Asia\/Shanghai/g' package/base-files/files/bin/config_generate
sed -i 's/GMT0/CST-8/g' package/base-files/files/bin/config_generate  
sed "/set system.ntp.enabled='1'/d" package/base-files/files/bin/config_generate
sed "/set system.ntp.enable_server='0'/d" package/base-files/files/bin/config_generate
sed -i "/set system\.@system\[-1\]\.urandom_seed='0'/c\\
set system.@system[-1].log_proto='udp'\\
set system.@system[-1].conloglevel='8'\\
set system.@system[-1].cronloglevel='7'" package/base-files/files/bin/config_generate

# Create Tailscale network
sed -i "/add_list network.loopback.ipaddr='127.0.0.1\/8'/a \\
  set network.tailscale=interface\\
  set network.tailscale.proto='none'\\
  set network.tailscale.device='tailscale0'\\
  set network.tailscale.packet_steering='1'" package/base-files/files/bin/config_generate
