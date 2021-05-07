echo '=========================================================='
echo '                Daniel Alejandro Rosas Almanza            '
echo '     Modelos de Arquitectura Orientada a Servivios        '
echo '                      La Salle Bajio                      '
echo '=========================================================='
echo '                           Inicio                         '
echo '=========================================================='
echo '===  PASO 1: Configurar Variable vm.max_map_count      ==='
echo '=========================================================='
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p

echo '=========================================================='
echo '===       PASO 2: Limpieza de Repositorio Local        ==='
echo '=========================================================='
if [ -d ~/MTIE_dara615342/ ]; then
    echo 'sudo rm -R MTIE_dara615342'
    sudo rm -R MTIE_dara615342
else
    echo 'El repositorio anterior no existe...'
fi

echo '=========================================================='
echo '===                    PASO 3: Git                     ==='
echo '=========================================================='
alias git="docker run -ti --rm -v $(pwd):/git bwits/docker-git-alpine"

echo '=========================================================='
echo '===             PASO 4: Clonar Repositorio            ==='
echo '=========================================================='
git clone https://github.com/DaniRAlmanza/MTIE_dara615342.git
cd MTIE_dara615342

echo '=========================================================='
echo '===   PASO 5: Carpeta de volumes para Elasticsearch    ==='
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
echo '===          PASO 6: Creacion de Contenedores          ==='
echo '=========================================================='
echo 'sudo docker-compose up --build -d'
sudo docker-compose up --build -d
