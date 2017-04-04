#!/bin/bash

/usr/bin/supervisord -c "/etc/supervisord.d/slapd.ini" & /bin/bash
