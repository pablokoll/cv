#!/bin/sh

git add .
git commit -m "Update CV"

branch_name=$(git rev-parse --abbrev-ref HEAD)
echo "$branch_name"
file_name=''
if echo "$branch_name" | grep -q "english"; then
    file_name='pablo koll cv.pdf'
    echo $file_name
else
    file_name='cv pablo koll.pdf'
    echo $file_name
fi

source './.env'

cp './cv.pdf' $EXPORT_ROUTE  # Reemplaza las rutas por las adecuadas

mv "$EXPORT_ROUTE/cv.pdf" "$EXPORT_ROUTE/$file_name"