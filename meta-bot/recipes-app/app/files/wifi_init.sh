SSID=""
Password=""

echo "Configuring wifi credentials"

wpa_passphrase $SSID $Password >> /etc/wpa_supplicant.conf
ifup wlan0

