# For 3
# OC - получение данных: название и версию ОС, версию и архитектуру ядра Linux
echo -e "------------------------OS------------------------"
echo -e "OS name and version:\t $(grep "^NAME=" /etc/os-release | cut -d '"' -f 2) $(grep "^VERSION=" /etc/os-release | cut -d '"' -f 2)"
echo -e "Version and core architecture:\t"`uname -rsm`
echo ""

# Вывести информацию о процессоре (Модель, частота, количество ядер, размер кэш-памяти)
echo -e "------------------------CPU------------------------"
echo -e $(lscpu | grep "Model")
# echo -e $(grep -E "cpu MHz|cpu cores|cache size" /proc/cpuinfo)
echo -e $(cat /proc/cpuinfo | grep "cpu MHz" | head -n 1)
echo -e $(cat /proc/cpuinfo | grep "cpu cores" | head -n 1)
echo -e $(cat /proc/cpuinfo | grep "cache size" | head -n 1)
echo ""

# Вывести информацию о размере оперативной памяти (Доступный размер, общий размер, использованный размер памяти)
echo -e "------------------------RAM------------------------"
echo -e "$(grep -E "MemTotal|MemFree|MemAvailable" /proc/meminfo)"
echo ""

# For 4
#Вывести параметры (имя, ip/mac) и скорость сетевого соединения
echo -e "------------------------USER------------------------"
echo -e "Hostname:\t"`hostname`
interface=$(ip route | grep '^default' | awk '{print $5}')
echo -e "Interface:\t $interface"
echo -e "IP address:\t $(ip addr show $interface | grep 'inet ' | awk '{print $2}')"
echo -e "MAC address:\t $(ip addr show $interface | grep 'link/ether' | awk '{print $2}')"
echo -e "Speed:\t $(cat /sys/class/net/$interface/speed) Mbit/s"
echo "" 

# ip route 
# ip addr show $interface
# echo -e "Speed: $(ethtool $interface | grep -i speed | awk '{print $2}')"

#Вывести информацию о системных разделах (точка монтирования, размер раздела, занятое/свободное пространство)
echo -e "------------------------SYSTEM PARTITIONS------------------------"
# lsblk
echo -e "Filesystem     Size   Used Avail Use% Mounted on"
#df -h| grep ^/dev
# Информация о всех разделах
df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs | grep ^/dev
echo ""
# lscpu

# 5 — Версия ядра.
# 15 — Основная редакция.
# 153 — Незначительная редакция.
# 1 — Номер патча.
#x86_64 - архитектура ядра

# echo -e "Hostname:\t\t"`hostname`
# echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name`
# echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version`
# echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial`
# echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
# echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
# echo -e "Kernel:\t\t\t"`uname -r`