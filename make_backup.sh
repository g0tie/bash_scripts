#!/bin/bash

name=$(date +%Y-%b-%m)
name="backup_$name.tar"
echo "Creating backup in current folder.."
tar -cvf $name $HOME/Documents $HOME/Archives $HOME/Images $HOME/Vidéos
echo "Backup created in $(pwd)"
