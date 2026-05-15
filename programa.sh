#!/bin/bash
declare -A equipos

partidos_jugados=0

partidos=()

function equipo_existe() {
    local equipo=$1
    local a_retornar=1
    for e in "${!equipos[@]}"
    do
        if [ "$e" == "$equipo" ]
        then
            a_retornar=0
            break
        fi
    done
    return $a_retornar
}

function agregar_equipo() {
    if [ ${#equipos[@]} -lt 15 ]
    then
        local nombre_equipo=""
        echo "ingrese el nombre del equipo"
        read nombre_equipo
        while [ "$nombre_equipo" == ""  ]
        do
            echo "ingrese el nombre del equipo, no puede estar vacio"
            read nombre_equipo
        done
        if equipo_existe "$nombre_equipo" 
        then
            echo "el equipo ya existe"
        else
            equipos[$nombre_equipo]=0
            echo "equipo $nombre_equipo agregado"
        fi
    else
        echo "se ha alcanzado el límite de equipos"
    fi
    read -p "presione enter para continuar"
}

function listar_equipos() {
    if [ ${#equipos[@]} -gt 0 ]
    then
        echo "equipos registrados:"
        for equipo in "${!equipos[@]}"
        do
            echo "$equipo"
        done
    else
        echo "no hay equipos registrados"
    fi
    read -p "presione enter para continuar"
}

function buscar_equipo() {
    local nombre_equipo=""
    echo "ingrese el nombre del equipo a buscar"
    read nombre_equipo
    while [ "$nombre_equipo" == ""  ]
    do
        echo "ingrese el nombre del equipo a buscar, no puede estar vacio"
        read nombre_equipo
    done
    if equipo_existe "$nombre_equipo" 
    then
        echo "el equipo $nombre_equipo está registrado"
    else
        echo "el equipo $nombre_equipo no está registrado"
    fi
    read -p "presione enter para continuar"
}


function registrar_partido (){
    local equipo1=""
    local equipo2=""
    local goles1=0
    local goles2=0
    echo "ingrese el nombre del equipo 1"
    read equipo1
    if ! equipo_existe "$equipo1" 
        then
            echo "el equipo no existe"
        else
        echo "ingrese el nombre del equipo 2"
        read equipo2
        if ! equipo_existe "$equipo2"
            then
                echo "el equipo no existe"
            else
                while [ $goles1 -le 0 ] || [ $goles2 -le 0 ]
                do
                clear
                echo "ingrese la cantidad de goles anotados por $equipo1"
                read goles1
                echo "ingrese la cantidad de goles anotados por $equipo2"
                read goles2
                if [ $goles1 -le 0 ] || [ $goles2 -le 0 ]
                then 
                    echo "la cantidad de goles debe ser mayor a 0"
                fi
                done
                if [ $goles1 -gt $goles2 ];
                then
               
                    echo   "$equipo1 gano"
                    ((equipos[$equipo1]+=3))
                elif [ $goles1 -lt $goles2 ];
                then
                    echo   "$equipo2 gano"
                    ((equipos[$equipo2]+=3))
                elif [ $goles1 -eq $goles2 ];
                    then
                        echo   " hubo empate"
                        ((equipos[$equipo1]+=1))
                        ((equipos[$equipo2]+=1))
                fi
                ((partidos_jugados++))
                partidos+=("$equipo1 $goles1 - $goles2 $equipo2")
        fi
    fi
    read -p "presione enter para continuar"
}

function ver_historial_de_partidos() {
    if [ ${#partidos[@]} -gt 0 ]
    then
        echo "historial de partidos jugados:"
        for partido in "${partidos[@]}"
        do
            echo "$partido"
        done
    else
        echo "no se han registrado partidos"
    fi
    read -p "presione enter para continuar"

}

function mostrar_partidos_jugados() {
    echo "cantidad de partidos jugados: $partidos_jugados"
    read -p "presione enter para continuar"
}

function mostrar_campeon() {
    if [ ${#equipos[@]} -gt 0 ]
    then
        local campeon=""
        local max_puntos=-1
        for equipo in "${!equipos[@]}"
        do
            if [ ${equipos[$equipo]} -gt $max_puntos ]
            then
                max_puntos=${equipos[$equipo]}
                campeon=$equipo
            fi
        done
        echo -e "el campeon del utimo torneo fue argentina,\nel campeón actual es: $campeon con $max_puntos puntos"
    else
        echo -e "el campeon del utimo torneo fue argentina,\nno hay equipos registrados para determinar el campeón actual"
    fi
    read -p "presione enter para continuar"
}
en_programa=true
while [ $en_programa == true ] 
do
    clear
    echo "1. Agregar equipo"
    echo "2. Listar equipos"
    echo "3. Registrar partido"
    echo "4. Buscar equipo"
    echo "5. Ver historial de partidos"
    echo "6. Mostrar cantidad de partidos jugados"
    echo "7. Mostrar campeón"
    echo "8. Salir"
    echo "ingrese una opción"
    read opcion
    case $opcion in
        1) clear && agregar_equipo;;
        2) clear && listar_equipos;;
        3) clear && registrar_partido;;
        4) clear && buscar_equipo;;
        5) clear && ver_historial_de_partidos;;
        6) clear && mostrar_partidos_jugados;;
        7) clear && mostrar_campeon;;
        8) en_programa=false;;
        *) clear && read -p "opción inválida presione enter para continuar" ;;
    esac
done
