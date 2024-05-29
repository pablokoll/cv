#!/bin/sh
set -e
echo $OSTYPE
# Verificar si xelatex está instalado
if ! command -v xelatex &> /dev/null; then
    echo "xelatex no está instalado. Intentando instalar..."

    # Detectar el sistema operativo y usar el comando de instalación adecuado
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -x "$(command -v apt-get)" ]; then
            echo "Instalando texlive-xetex en Linux (apt-get)..."
            sudo apt-get update
            sudo apt-get install -y texlive-xetex
        elif [ -x "$(command -v dnf)" ]; then
            echo "Instalando texlive-xetex en Linux (dnf)..."
            sudo dnf install -y texlive-xetex
        else
            echo "No se pudo detectar el manejador de paquetes adecuado en Linux."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Instalando MacTeX en macOS..."
        # Aquí puedes poner el comando de instalación para macOS
    elif [[ "$OSTYPE" == "msys"* ]]; then
        echo "Instalando Tex en MSYS..."
        pacman -S texlive-bin
    else
        echo "Sistema operativo no soportado para la instalación automática de xelatex."
        exit 1
    fi
else
    echo "xelatex ya está instalado."
fi

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