#!/bin/bash
VAR1="kur"
playit="playit"
java8="java8"
java17="java17"
mc1193="server1.19.3"
mc1182="server1.18.2"
mc1165="server1.16.5"


# -------------------------kurulum baslangic---------------------------------
if [ $# -gt 0 ]
then
    VAR1=$1
else
	echo "kullanım : $0 start,setup,setupremove,console"
    exit 1;
fi
if [ "$VAR1" == "setup" ]
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
        echo "1.19.3 | papermc"
        echo "1.18.2 | papermc"
        echo "1.16.5 | papermc"
        echo ""
        read -r -p "Select: " version
fi
# -------------------------selector bitis---------------------------------


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
    wget https://github.com/barkeser2002/minecraft-server-for-google-cloud-shell/raw/main/versions-paper/paper-1.16.5.jar -O $mc1165/server.jar
    sudo chmod 777 ./$mc1165/*
rm -f ./$mc1165/start.sh
tee -a ./$mc1165/start.sh <<EOF
#!/bin/bash
../java8/bin/java -jar server.jar
EOF
    sudo chmod 777 $mc1165/*
    sudo chmod 777 ./$mc1165
    echo "1.16.5 İnstallation Finish | $0 start"
fi

#-----------------------------------------------------

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
    mkdir $mc1182
    cp -r ./template/* $mc1182/
    wget https://github.com/barkeser2002/minecraft-server-for-google-cloud-shell/raw/main/versions-paper/paper-1.18.2.jar -O $mc1182/server.jar
rm -f ./$mc1182/start.sh
tee -a ./$mc1182/start.sh <<EOF
#!/bin/bash
../java16/bin/java -jar server.jar
EOF
    sudo chmod 777 $mc1182/*
    sudo chmod 777 ./$mc1182
    echo "1.18.2 İnstallation Finish | $0 start"
fi

#-----------------------------------------------------

if [ "$version" == "1.19.3" ]
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
    echo "1.19.3 kuruluyor..."
    echo "$mc1193 Klasör Oluşturuluyor.."
    mkdir $mc1193
    cp -r ./template/* $mc1193/
    wget https://github.com/barkeser2002/minecraft-server-for-google-cloud-shell/raw/main/versions-paper/paper-1.19.3.jar -O $mc1193/server.jar
rm -f ./$mc1193/start.sh
tee -a ./$mc1193/start.sh <<EOF
#!/bin/bash
../java16/bin/java -jar server.jar
EOF
    sudo chmod 777 $mc1193/*
    sudo chmod 777 ./$mc1193
    echo "1.19.3 İnstallation Finish | $0 start"
fi

# -------------------------kurulum bitis---------------------------------


# -------------------------baslat baslangic---------------------------------
if [ "$VAR1" == "start" ]
then
        echo "Kurulumlar Taranıyor.."
        sleep 2
        if [ -d $mc1193 ]; then
        echo "+ 1.19.3 | papermc"
        fi
        if [ -d $mc1182 ]; then
        echo "+ 1.18.2 | papermc"
        fi
        if [ -d $mc1165 ]; then
        echo "+ 1.16.5 | papermc"
        fi
        echo ""
        read -r -p "Select: " versionstart
fi

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
if [ "$versionstart" == "1.19.3" ]
then
	  screen -S playit -dm bash -c 'cd playit; ./playit;'
      screen -S minecraftserver -dm bash -c 'cd server1.19.3; ./start.sh;'
fi
# -------------------------baslat bitis---------------------------------

# -------------------------konsol baslangic---------------------------------
if [ "$VAR1" == "console" ]
then
        clear
        echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın."
        sleep 3
         echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın.."
        sleep 3
         echo "Konsol Açılıyor Çıkış Yapmak İçin İlk Önce (CTRL+A) Sonra (CTRL+D) yapın..."
        sleep 3
        screen -r minecraftserver
fi
# -------------------------konsol bitis---------------------------------





# -------------------------kurulumsil baslangic---------------------------------
if [ "$VAR1" == "setupremove" ]
then
        echo "Kurulumlar Taranıyor.."
        sleep 2
        if [ -d $mc1193 ]; then
        echo "+ 1.19.3 | papermc"
        fi
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
        read -r -p "Select: " versionsil
fi

if [ "$versionsil" == "1.19.3" ]
then
    clear
    sudo rm -f -r $mc1193
    echo "1.19.3 Setup Removed"
fi

if [ "$versionsil" == "1.18.2" ]
then
    clear
    sudo rm -f -r $mc1182
    echo "1.18.2 Setup Removed"
fi

if [ "$versionsil" == "1.16.5" ]
then
    clear
    sudo rm -f -r $mc1165
    echo "1.16.5 Setup Removed"
fi

if [ "$versionsil" == "playit" ]
then
    clear
    sudo rm -f -r $playit
    echo "Playit removed"
fi
# -------------------------kurulumsil bitis---------------------------------
