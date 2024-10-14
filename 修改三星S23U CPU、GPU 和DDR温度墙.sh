#!/system/bin/sh

SET_TRIP_POINT_TEMP_MAX=150000
km1() {
    echo -e "$@"
}
km2() {
    echo -e "❗️ $@"
}
lock_value() {
    if [[ ! -f "$1" ]]; then
        km2 "命令:($1) 位置不存在跳过..."
        return 1
    fi
    chown root:root "$1" 2>/dev/null || km2 "变更所有者失败:($1)"
    chmod 0644 "$1" 2>/dev/null || km2 "变更权限失败:($1)"
    local curval
    curval=$(cat "$1" 2> /dev/null) || { km2 "读取:($1) 失败"; return 1; }
    if [[ "$curval" == "$2" ]]; then
        km1 "命令:$1 参数已存在 ($2) 跳过..."
        return 0
    fi
    if ! echo -n "$2" > "$1" 2> /dev/null; then
        km2 "写入:($1) -❌-> 命令 $2 参数失败"
        return 1
    fi
    chmod 0444 "$1"
    km1 "写入:$1 $curval -✅-> 命令 ($2) 参数成功"
}
lock_trip_point() {
    local TRIP_POINT_TEMP=$1
    if [ "$(cat "$TRIP_POINT_TEMP")" -lt "$SET_TRIP_POINT_TEMP_MAX" ]; then
        lock_value "$TRIP_POINT_TEMP" "$SET_TRIP_POINT_TEMP_MAX"
    fi
}
for THERMAL_ZONE in /sys/class/thermal/thermal_zone*/type; do
    if grep -qE "cpu|gpu|ddr" "$THERMAL_ZONE"; then
        for TRIP_POINT_TEMP in "${THERMAL_ZONE%/*}"/trip_point_*_temp; do
            lock_trip_point "$TRIP_POINT_TEMP"
        done
    fi
done
