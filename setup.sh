VAR1="kur"
playit="playit"
java8="java8"
java17="java17"
mc1182="server1.18.2"
mc1165="server1.16.5"


# -------------------------selector baslangic---------------------------------
if [ $# -gt 0 ]
then
    VAR1=$1
else
	echo "kullanım : $0 başlat,kurulum,kurulumsil,konsole"
    exit 1;

if [ "$VAR1" == "kurulum" ]
then
        if [ ! -d $playit ]; then
             sudo apt install -y screen aria2
             echo "$playit Klasör Oluşturuluyor.."
             mkdir $playit
             wget https://github.com/playit-cloud/playit-agent/releases/download/v0.9.3/playit-0.9.3 -O playit/playit
             sudo chmod 777 $playit/*
             sudo chmod 777 ./$playit
             clear
             echo "Tek Seferlik Playit Ayarları Açılacak Bağlantı Tamamlandıktan Sonra (CTRL + C) Yapınız"
             sleep 8

             screen -S playit -m bash -c 'cd playit; ./playit;'
        fi
        echo ""
        echo "1.16.5 | papermc"
        echo "1.18.2 | papermc"
        echo ""
        read -p "Seçim: " version
fi
if [ "$VAR1" == "başlat" ]
then
        echo "Kurulumlar Taranıyor.."
        sleep 2
        if [ -d $mc1182 ]; then
        echo "+ 1.18.2 | papermc"
        fi
        if [ -d $mc1165 ]; then
        echo "+ 1.16.5 | papermc"
        fi
        echo ""
        read -p "Seçim: " versionstart
fi
if [ "$VAR1" == "kurulumsil" ]
then
        echo "Kurulumlar Taranıyor.."
        sleep 2
        if [ -d $mc1182 ]; then
        echo "+ 1.18.2 | papermc"
        fi
        if [ -d $mc1165 ]; then
        echo "+ 1.16.5 | papermc"
        fi
        if [ -d $playit ]; then
        echo "+ playit | ip hizmeti resetlemek için kullanın"
        fi
        echo ""
        read -p "Seçim: " versionsil
fi

if [ "$VAR1" == "konsole" ]
then
        clear
        echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın."
        sleep 2
         echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın.."
        sleep 2
         echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın..."
        sleep 2
        screen -r minecraftserver
fi
# -------------------------selector bitis---------------------------------

# -------------------------baslat baslangic---------------------------------
if [ "$versionstart" == "1.16.5" ]
then
	  screen -S playit -dm bash -c 'cd playit; ./playit;'
      screen -S minecraftserver -dm bash -c 'cd server1.16.5; ./start.sh;'
fi
if [ "$versionstart" == "1.18.2" ]
then
	  screen -S playit -dm bash -c 'cd playit; ./playit;'
      screen -S minecraftserver -dm bash -c 'cd server1.18.2; ./start.sh;'
fi


# -------------------------baslat bitis---------------------------------

# -------------------------kurulum baslangic---------------------------------
if [ "$version" == "1.16.5" ]
then

    if [ ! -d $java8 ]; then
    echo "Java Kuruluyor..."
     wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jre_x64_linux_hotspot_8u352b08.tar.gz -O $java8.tar.gz
    tar xfv $java8.tar.gz
    mv jdk* $java8
    sudo chmod 777 $java8/*
    sudo chmod 777 $java8/*/*
    sudo chmod 777 $java8/*/*/*
    fi
    clear
    echo "1.16.5 kuruluyor..."
    echo "$mc1165 Klasör Oluşturuluyor.."
    mkdir $mc1165
    cp -r ./template/* $mc1165/
     wget https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar -O $mc1165/server.jar
rm -f ./$mc1165/start.sh
tee -a ./$mc1165/start.sh <<EOF
../java8/bin/java -jar server.jar
EOF
    sudo chmod 777 $mc1165/*
    sudo chmod 777 ./$mc1165
    echo "1.16.5 kurulum bitti | $0 start"
fi

if [ "$version" == "1.18.2" ]
then

        if [ ! -d $java17 ]; then
    echo "Java Kuruluyor..."
     wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jre_x64_linux_hotspot_17.0.5_8.tar.gz -O $java17.tar.gz
    tar xfv $java17.tar.gz
    mv jdk* $java17
    sudo chmod 777 $java17/*
    sudo chmod 777 $java17/*/*
    sudo chmod 777 $java17/*/*/*
    fi
    clear
    echo "1.18.2 kuruluyor..."
    echo "$mc1182 Klasör Oluşturuluyor.."
    mkdir $mc1165
    cp -r ./template/* $mc1182/
    wget https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar -O $mc1165/server.jar
rm -f ./$mc1182/start.sh
tee -a ./$mc1182/start.sh <<EOF
../java16/bin/java -jar server.jar
EOF
    sudo chmod 777 $mc1182/*
    sudo chmod 777 ./$mc1182
    echo "1.18.2 kurulum bitti | $0 start"
fi

# -------------------------kurulum bitis---------------------------------





























# -------------------------kurulumsil baslangic---------------------------------
if [ "$versionsil" == "1.16.5" ]
then
    clear
    sudo rm -f -r $mc1165
    echo "1.16.5 kurulum silindi"
fi

if [ "$versionsil" == "1.18.2" ]
then
    clear
    sudo rm -f -r $mc1182
    echo "1.18.2 kurulum silindi"
fi
if [ "$versionsil" == "playit" ]
then
    clear
    sudo rm -f -r $playit
    echo "Playit silindi"
fi
# -------------------------kurulumsil bitis---------------------------------
