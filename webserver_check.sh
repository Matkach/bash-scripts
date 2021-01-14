#!/bin/bash

if [[ `ps -acx|grep apache|wc -l` > 0 ]]; then
    echo "Configured with Apache"
fi
if [[ `ps -acx|grep nginx|wc -l` > 0 ]]; then
    echo "Configured with Nginx"
fi
