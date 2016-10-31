#!/bin/bash

puppet apply --modulepath `pwd`/modules --noop launch.pp
echo "Control C now if it's broke..."
sleep 10
puppet apply --modulepath `pwd`/modules launch.pp
