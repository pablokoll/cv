#!/bin/sh
set -e

# Verifica si xelatex está instalado
if ! command -v xelatex &> /dev/null; then
    echo "xelatex no está instalado. Instalando texlive-xetex..."
    # Detectar el sistema operativo y usar el comando de instalación adecuado
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y texlive-xetex
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install mactex
    else
        echo "Sistema operativo no soportado para la instalación automática de xelatex"
        exit 1
    fi
else
    echo "xelatex ya está instalado"
fi

echo "Exportando CV usando XeLaTeX..."

xelatex './cv.tex'

git add .
git commit -m 'updated cv file' --no-verify

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

git push