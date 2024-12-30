#github.com/twncer
#btuncer42
arc=$(uname -m)
kernel_v=$(uname -r)
phy_proc_count=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
virt_proc_count=$(grep "^processor" /proc/cpuinfo | wc -l)
ram_info=$(top -b -n 1 | grep "MiB Mem" | head -n 1)
ram_usage_percent=$(top -b -n 1 | grep "MiB Mem" | head -n 1 | awk '{print (($8 * 100) / $4) "%"}')
cpu_usage=$(top -b -n1 | grep "%Cpu")
uptime=$(uptime -s)
is_lvm_active=$(if sudo vgs --noheadings | grep -q "LVMGroup"; then echo "Aktif"; else echo "Aktif değil"; fi)
active_connections=$(ss -an state ESTABLISHED | wc -l)
active_users=$(who | wc -l) 
ipv4=$(ip address show | grep inet | sed -n '3p' | awk '{print $2}')
mac_addr=$(ip link show | grep -i ether | awk '{print $2}')
sudo_command_count=$(grep "COMMAND=/" /var/log/sudo/sudo.log | wc -l)
available_storage=$(df / | tail -n +2 | awk '{print $4}')
storage_usage_perc=$(df / | tail -n +2 | awk '{print $5}')

wall  "*-- btuncer --*

ı-------------------------------------------------ı
> Sistem mimarisi  => $arc
> Kernel versiyonu => $kernel_v
> Fiziksel işlemci sayısı => $phy_proc_count
> Sanal işlemci sayısı    => $virt_proc_count

> Ram durumu =>
$ram_info
> Ram kullanım yüzdesi => $ram_usage_percent
> Müsait depolama alanı                => $available_storage m
> Depolama alanının kullanım yüzdeliği => $storage_usage_perc

> Cpu kullanımı =>
$cpu_usage
> Son yeniden başlatma   => $uptime
> LVM aktif mi?          => $is_lvm_active 
> Aktif bağlantı sayısı  => $active_connections
> Aktif kullanıcı sayısı => $active_users
> IPv4 adresi            => $ipv4
> MAC adresi             => $mac_addr  
> Sudo ile çalıştırılan komut sayısı => $sudo_command_count
ı-------------------------------------------------ı
"
