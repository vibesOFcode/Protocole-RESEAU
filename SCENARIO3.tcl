# --- INITIALISATION DU SIMULATEUR ---
set ns [new Simulator]

# Ouverture des fichiers de trace
set namfile [open out.nam w]
$ns namtrace-all $namfile

set tracefile [open sanet_trace.tr w]
$ns trace-all $tracefile

# --- CRÉATION DES NOEUDS ---
set src1 [$ns node]
set src2 [$ns node]
set gw1  [$ns node]
set gw2  [$ns node]
set gw3  [$ns node]
set dst1 [$ns node]
set dst2 [$ns node]

# --- DÉFINITION DES LIENS (Topologie) ---
$ns duplex-link $src1 $gw1 1Mb 10ms DropTail
$ns duplex-link $src2 $gw2 1Mb 10ms DropTail
$ns duplex-link $gw1  $gw3 1Mb 10ms DropTail
$ns duplex-link $gw2  $gw3 1Mb 10ms DropTail
$ns duplex-link $gw3  $dst1 1Mb 10ms DropTail
$ns duplex-link $gw3  $dst2 1Mb 10ms DropTail

# --- CONFIGURATION DU FLUX 1 (TCP Vegas) ---
set tcp1 [new Agent/TCP/Vegas]
$ns attach-agent $src1 $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $dst1 $sink1

$ns connect $tcp1 $sink1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

# --- CONFIGURATION DU FLUX 2 (TCP Vegas) ---
# Dans le scénario 3, le deuxième flux est aussi en Vegas
set tcp2 [new Agent/TCP/Vegas]
$ns attach-agent $src2 $tcp2

set sink2 [new Agent/TCPSink]
$ns attach-agent $dst2 $sink2

$ns connect $tcp2 $sink2

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP

# --- PLANIFICATION DES ÉVÉNEMENTS ---
$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp2 start"
$ns at 10.0 "finish"

# --- PROCÉDURE DE FIN ---
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    puts "Lancement de l'animateur NAM..."
    exec nam out.nam &
    exit 0
}

# --- DÉMARRAGE DE LA SIMULATION ---
$ns run