inherit core-image
CORE_IMAGE_EXTRA_INSTALL += "pigpio"
CORE_IMAGE_EXTRA_INSTALL += "app"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -p '$(openssl passwd balbot)' root;"