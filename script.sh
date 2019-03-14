#!/bin/bash

status=`service apache2 status`

echo -e `$status|grep "running"`