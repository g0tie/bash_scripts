#!/bin/bash

$date = $(date date +%Y-%b-%m)
echo "Creating backup in current folder.."
tar -cvf backup_$date.tar $HOME/Documents $HOME/Archives $HOME/Images $HOME/Vidéos
echo "Backup created in $(pwd)"
