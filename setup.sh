#!/bin/bash
echo '=========================================================='
echo '                Daniel Alejandro Rosas Almanza            '
echo '     Modelos de Arquitecturas Orientadas a Servicios      '
echo '                        La Salle Bajio                     '
echo '=========================================================='
echo '                                                          '
echo '=========================================================='
echo '===     PASO 1: Configurar Variable VM.MAX_MAP_COUNT   ==='
echo '=========================================================='
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p

echo '=========================================================='
echo '===      PASO 2: Intalacion de Docker-Compose          ==='
echo '=========================================================='
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo '=========================================================='
echo '===       PASO 3: Limpieza de Repositorio              ==='
echo '=========================================================='
if [ -d ~/MTIE_dara615342/ ]; then
    echo 'sudo rm -R MTIE_dara615342'
    sudo rm -R MTIE_dara615342
else
    echo 'El repositorio anterior no existe...'
fi

echo '=========================================================='
echo '===                    PASO 4: Git                     ==='
echo '=========================================================='
alias git="docker run -ti --rm -v $(pwd):/git bwits/docker-git-alpine"

echo '=========================================================='
echo '===             PASO 5: Clonar Repositorio             ==='
echo '=========================================================='
git clone https://github.com/DaniRAlmanza/MTIE_dara615342.git
cd MTIE_dara615342

echo '=========================================================='
echo '===          PASO 6: Limpieza de Data                  ==='
echo '=========================================================='
if [ -d ~/volumes/ ]; then
    echo 'sudo rm -R volumes'
    sudo rm -R volumes
else
    echo ''
    echo 'No existe la carpeta volumes anterior...'
fi

if [ -d ~/data/ ]; then
    echo 'sudo rm -R data'
    sudo rm -R data
else
    echo ''
    echo 'No existe la carpeta volumes data anterior...'
fi

echo '=========================================================='
echo '===   PASO 7: Carpetas de volumes para Elasticsearch   ==='
echo '=========================================================='
if [ -d ./volumes/ ]; then
    sudo cp -R volumes/ ~/
    sudo mkdir -p ~/volumes/elk-stack/elasticsearch
    cd ~/volumes/elk-stack/
    sudo chmod 777 elasticsearch/
    cd ~/MTIE_dara615342
else
    echo 'No existe la carpeta volumes'
fi

if [ -d ./data/ ]; then
    echo 'sudo cp -R data/ ~/'
    sudo cp -R data/ ~/
else
    echo 'No existe la carpeta data'
fi

echo '=========================================================='
echo '===          PASO 8: Creacion de Contenedores          ==='
echo '=========================================================='
echo 'sudo docker-compose up --build -d'
sudo docker-compose up --build -d
