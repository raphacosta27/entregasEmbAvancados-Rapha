target extended-remote :8080
remote put /home/raphacosta/Desktop/HPS-Hello/hps_gpio hps_gpio
set remote exec-file hps_gpio
run
