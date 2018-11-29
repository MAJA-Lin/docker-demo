#!/bin/bash

FILE=./.env
if [ -f $FILE ]; then
    echo "Env file alreay exists!"
else
    cp env-example ./.env
    echo "Env file created successfully."
fi

chmod -R 777 ./logs