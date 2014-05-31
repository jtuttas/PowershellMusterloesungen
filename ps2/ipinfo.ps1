function ipinfo($ip) {
    $ip
    [int[]]$x = $ip.Split(".")
    if($x[0] -le 127)
    {
        "Class A"
    }
    elseif($x[0] -gt 127 -and $x[0] -le 191)
    {
        "Class B"
    }
    elseif($x[0] -gt 191 -and $x[0] -le 223)
    {
        "Class C"
    }

    if ($x[0] -ge 1 -and $x[0] -le 127) {
        "Default Subnet 255.0.0.0"
    }
    elseif ($x[0] -ge 128 -and $x[0] -le 191) {
        "Default Subnet 255.255.0.0"
    }
    elseif ($x[0] -ge 192 -and $x[0] -le 233) {
        "Default Subnet 255.255.255.0"
    }

    if ($x[0] -eq 10) {
        return "private IP"
    }
    elseif ($x[0] -eq 172 -and ($x[1] -ge 16 -and $x[1] -le 31)) {
        return "private IP"
    }
    elseif ($x[0] -eq 192 -and $x[1] -eq 168) {
        return "private IP"
    }
    else {
        return "public ip"
    }
}

ipinfo "192.178.178.6"
ipinfo "10.16.192.1"
ipinfo "172.32.4.5"
ipinfo "172.32.4.5"
ipinfo "130.75.1.5"