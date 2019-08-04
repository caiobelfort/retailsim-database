#!/bin/bash

HOST=$1
DATABASE=$2
USER=$3
PASSWORD=$4

export PGPASSWORD=$PASSWORD

# Copy aisle
echo Copying aisle data to products.aisle
psql -h $HOST -d $DATABASE -U $USER -c \ "copy products.aisle (id, name) from STDIN with delimiter as ',' CSV HEADER;" < data/aisles.csv

# Copy department
echo Copying department data to products.depatment
psql -h $HOST -d $DATABASE -U $USER -c \ "copy products.department (id, name) from STDIN with delimiter as ',' CSV HEADER;" < data/departments.csv

# Copy products
echo Copying product data to products.product
psql -h $HOST -d $DATABASE -U $USER -c \ "copy products.product (id, name, aisle_id, department_id) from STDIN with delimiter as ',' CSV HEADER;" < data/products.csv


