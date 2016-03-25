#!/bin/bash

# Check if CouchDB is installed.
COUCHDB_INSTALLED = $(dpkg-query -W --showformat='${Status}\n' couchdb|grep "install ok installed")
echo "Checking for CouchDB: $COUCHDB_INSTALLED"

# Install CouchDB if it does not exist.
if [ "" == "$COUCHDB_INSTALLED" ]; then
  echo "CouchDB is not installed."
  echo "Updating packages..."
  sudo apt-get update

  echo "Adding PPA..."
  sudo apt-get install software-properties-common -y
  sudo add-apt-repository ppa:couchdb/stable -y

  echo "Updating packages one last time..."
  sudo apt-get update

  echo "Install CouchDB..."
  sudo apt-get install couchdb -y
fi
