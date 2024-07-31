#!/bin/bash

# Abrir página del juego
firefox index.html &> /dev/null &

# Definir desafíos y claves
declare -A desafios
desafios[1]="Nivel 1: Listar todos los archivos en el directorio actual."
desafios[2]="Nivel 2: Mostrar el contenido del archivo /tmp/nivel2.txt."
desafios[3]="Nivel 3: Mostrar las primeras 5 líneas del archivo /tmp/nivel3.txt."
desafios[4]="Nivel 4: Buscar la palabra 'challenge' en el archivo /tmp/nivel4.txt."
desafios[5]="Nivel 5: Desafío aún no definido."
desafios[6]="Nivel 6: Desafío aún no definido."
desafios[7]="Nivel 7: Desafío aún no definido."
desafios[8]="Nivel 8: Desafío aún no definido."
desafios[9]="Nivel 9: Desafío aún no definido."
desafios[10]="Nivel 10: Contar el número de veces que aparece la letra 'x' en el archivo /tmp/desafio10/contar_x.txt."
desafios[11]="Nivel 11: Algo sucedió con el archivo hexadecimal que contiene la clave en el directorio /tmp/desafio11/. Fue ligeramente corrompido conteniendo los siguientes símbolos @ ! # en ASCII. Busca la forma de filtrar estos símbolos y obtener la clave correcta."
desafios[12]="Nivel 12: Se acaban de crear tres archivos en ubicaciones desconocidas dentro las carpetas tmp y home (~) los cuales contienen las tres partes de la clave para este desafío. Usa find y filtra la información para obtener un archivo con la ruta de estos archivos modificados hace poco (-mmin 1) y accede en ellos. Tip: los nombres de estos archivos empiezan con 'secret_part'."
desafios[13]="Nivel 13: Se han creado tres archivos ocultos en la carpeta /tmp/. Se debe usar una combinación de los comandos find y xargs para procesar estos archivos. Se recomienda generar un archivo de salida que contenga los números de líneas, palabras y caracteres para cada archivo, respectivamente."
desafios[14]="Nivel 14: Desafío aún no definido."
desafios[15]="Nivel 15: Desafío aún no definido."

declare -A claves
claves[1]="BashGameProject"
claves[2]="claveNivel2"
claves[3]="claveNivel3"
claves[4]="claveNivel4"
claves[10]="31"
claves[11]="deamo%n32o&4n%00^01*12%22._dea_m4o%n_2-o&*n%00^01%*12%x2%%2ae33l02w_2d1a"
claves[12]="zero21ohlord_221one-*"
claves[13]="10_37_40"

# Función para generar archivos
function generar_archivo {
    local nivel="$1"
    case $nivel in
        2)
            echo "Contenido del nivel 2. Clave: claveNivel2" > /tmp/nivel2.txt
            ;;
        3)
            echo -e "Linea 1\nLinea 2\nLinea 3\nLinea 4\nLinea 5\nLinea 6\nClave: claveNivel3" > /tmp/nivel3.txt
            ;;
        4)
            echo -e "Esta es una línea\nchallenge\nOtra línea más\nClave: claveNivel4" > /tmp/nivel4.txt
            ;;
        10)
            mkdir -p /tmp/desafio10
            echo -e "a1b2c3x@!#x^&()_+|}{\":?><,./x\nx1234567890x!@#$%^&()+-=~|x qwertyuiopasdfghjklzxcvbnmXxXx 12x34x56x78x90!@#$%^&*()_+|}{: xzcvbnmasdfghjkl;':,.<>?1234567890 ~!@#$%^&*()+-=x|}{\":?><,./x\nxXxXxXxXxXxXxXxXxXxXxXxXxXxXx\na!b@c#de%f^g&h*i(j)k+l,m.n/o\n;\'\"?" > /tmp/desafio10/contar_x.txt
            ;;
        11)
            mkdir -p /tmp/desafio11
            echo -e "64 23 65 40 61 21 6d 23 6f 25 6e 33 32 6f 26 34 6e 23 25 21 30 30 23 5e 30 31 40 2a 31 32 21 25 32 32 2e 5f 64 23 65 40 61 5f 21 6d 34 23 40 6f 25 6e 5f 32 21 2d 6f 26 40 2a 6e 23 25 21 30 30 23 5e 40 30 31 25 40 2a 31 32 21 25 21 78 32 25 25 32 61 40 40 65 33 23 23 33 23 21 6c 30 32 77 21 40 23 40 5f 32 23 23 21 64 31 61" > /tmp/desafio11/corrompido.hex
            ;;
        12)
            echo "zero21" > /tmp/secret_part1.txt
            echo "ohlord_!" > ~/secret_part2.txt
            mkdir -p ~/documents/secrets/
            echo "221one-*" > ~/documents/secrets/secret_part3.txt
            ;;
        13)
            DIR="/tmp"
            mkdir -p $DIR/dir1 $DIR/dir2
            echo -e "G2r7#xL8\nkY9@Qz\nZ4b^Wc\n~1D4e\nL!m3O\n\nN5^%j\nbT@R7\nU8*k\nG2q!R" > $DIR/dir1/.hidden_file1
            echo -e "EassS T331 Edd Ess Saa Ueee Neeea A2 2R C2 H 2 raaI _V___ O Oas C UddL Tff O Cas asO dNs Ma U,,,, C,,, H.,,.. A.. .S... P... A... L.. A. ...B Ree Ass aaS" > $DIR/dir1/.hidden_file2
            echo -e "m*4@QD5!X#R2hKOJFdslsl{3322SCHARACTERS}" > $DIR/dir2/.hidden_file3
            ;;
        *)
            # Para niveles sin definición aún, puedes incluir mensajes si lo deseas
            echo "Nivel $nivel aún no definido o no requiere archivo."
            ;;
    esac
}

# Función para mostrar el desafío
function mostrar_desafio {
    local nivel="$1"
    if [ -n "${desafios[$nivel]}" ]; then
        echo -e "${desafios[$nivel]}"
        generar_archivo $nivel  # Generar el archivo para el nivel actual
    else
        echo "Nivel no encontrado."
    fi
}

# Función para pedir la clave
function pedir_clave {
    local nivel="$1"
    while true; do
        echo "Introduce la clave del nivel (o 'e' para volver al menú de niveles):"
        read clave

        if [ "$clave" == "e" ]; then
            return 1
        elif [ "$clave" == "${claves[$nivel]}" ]; then
            echo -e "Clave correcta! Bienvenido al Nivel $nivel.\n"
            return 0
        else
            echo -e "- - - - - - \n  Clave incorrecta. Intenta de nuevo. \n- - - - - -"
        fi
    done
}

# Función principal del juego
function juego {
    while true; do
        echo "Introduce el nivel (1-15):"
        read nivel
        if [ -z "${desafios[$nivel]}" ]; then
            echo "Nivel no válido."
            continue
        fi

        mostrar_desafio $nivel
        pedir_clave $nivel
        if [ $? -ne 0 ]; then
            continue
        fi

        # Permitir al usuario ejecutar comandos del nivel
        while true; do
            echo "Introduce un comando (o 's' para salir al menú de niveles):"
            read comando
            if [ "$comando" == "s" ]; then
                break
            else
                eval $comando
            fi
        done
    done
}

# Inicia el juego
juego
