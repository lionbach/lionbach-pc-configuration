      ******************************************************************
      *    Author:                Lionbach (Leo Mumbach)
      *    Date:                  16/03/2024
      *    Objetive:
      *    Comments:
      ******************************************************************

      ******************** IDENTIFICATION DIVISION *********************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                NOTAS001.

      ********************** ENVIRONMENT DIVISION **********************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT fc-notas ASSIGN TO "notas"
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT fc-notas-temp ASSIGN TO "notas-temp"
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT fc-notas-ejemplo ASSIGN TO "notas-ejemplo"
           ORGANIZATION IS LINE SEQUENTIAL.


      ************************* DATA DIVISION **************************
       DATA DIVISION.
       FILE SECTION.
       fd  fc-notas
           record contains 80 characters
           block contains 0 records.
       01  fs-notas               pic x(80).
       fd  fc-notas-temp
           record contains 80 characters
           block contains 0 records.
       01  fs-notas-temp          pic x(80).
       fd  fc-notas-ejemplo
           record contains 80 characters
           block contains 0 records.
       01  fs-notas-ejemplo       pic x(80).

       WORKING-STORAGE SECTION.
       01 ws-menu                 pic 99 value zeros.
       01 ws-numero-nota          pic 99 value zeros.
       01 ws-contador             pic 99 value zeros.
       01 ws-eof                  pic x value spaces. 
       01 ws-read-nota.
           05 ws-read-titulo      pic x(20) value spaces.
           05 ws-read-cuerpo      pic x(60) value spaces.
       01 ws-nueva-nota.
           05 ws-nuevo-titulo     pic x(20) value spaces.
           05 ws-nuevo-cuerpo     pic x(60) value spaces.

      *********************** PROCEDURE DIVISION ***********************
       PROCEDURE DIVISION.
       00-MAIN-PROCEDURE.
           display "Aplicacion: NOTAS".
           perform 05-bucle-principal.


       05-bucle-principal.
           perform 01-list-menu.
           perform 02-ir-a-opcion-menu.
           perform 05-bucle-principal.

       01-list-menu.
           display " "
           display "----- MENU -----".
           display "1) Listar.".
           display "2) Ver.".
           display "3) Crear."
           display "4) Borrar.".
           display "5) Cargar datos de ejemplo."
           display "6) Salir.".
           accept ws-menu.

       02-ir-a-opcion-menu.
           go to 03-opcion-listar             
                 04-opcion-ver             
                 05-opcion-crear             
                 06-opcion-borrar             
                 10-datos-ejemplo
                 99-fin
           depending on ws-menu.
           display "Opcion no valida".
           
       03-opcion-listar.
           display " "
           display "----- Lista de Notas -----"
           move 0 to ws-contador
           move "n" to ws-eof
           open input fc-notas
           perform until ws-eof="y"
             add 1 to ws-contador
             read fc-notas into ws-read-nota
             at end
               move "y" to ws-eof
             not at end
               display ws-contador ") - " ws-read-titulo
           end-perform
           close fc-notas
           go to 05-bucle-principal.

       04-opcion-ver.
           display " "
           display "----- Ver nota -----"
           display "Ingrese Numero de Nota:"
           accept ws-numero-nota
           move 0 to ws-contador
           move "n" to ws-eof
           open input fc-notas
           perform until ws-eof="y"
             add 1 to ws-contador
             read fc-notas into ws-read-nota
             at end
               move "y" to ws-eof
             not at end
               if ws-contador = ws-numero-nota
                 display ws-read-titulo
                 display ws-read-cuerpo
               end-if
           end-perform
           close fc-notas
           go to 05-bucle-principal.


       05-opcion-crear.
           display " "
           display "----- Nueva nota -----"
           display "Titulo:"
           accept ws-nuevo-titulo
           display "Cuerpo:"
           accept ws-nuevo-cuerpo
           open extend fc-notas
           write fs-notas from ws-nueva-nota
           close fc-notas
           go to 05-bucle-principal.


       06-opcion-borrar.
           display " "
           display "----- Borrar nota -----"
           display "Ingrese Numero de Nota:"
           accept ws-numero-nota
           perform 07-borrar-notas-a-temp
           perform 08-borrar-temp-a-notas
           perform 09-borrar-limpiar-temp
           go to 05-bucle-principal.

       07-borrar-notas-a-temp.
           move 0 to ws-contador
           move "n" to ws-eof
           open input fc-notas
           open output fc-notas-temp
           perform until ws-eof="y"
             add 1 to ws-contador
             read fc-notas into ws-read-nota
             at end
               move "y" to ws-eof
             not at end
               if ws-contador = ws-numero-nota
                 display "Borrando:"
                 display ws-read-titulo
               else
                 write fs-notas-temp from ws-read-nota
               end-if
           end-perform
           close fc-notas
           close fc-notas-temp.

       08-borrar-temp-a-notas.
           move 0 to ws-contador
           move "n" to ws-eof
           open output fc-notas
           open input fc-notas-temp
           perform until ws-eof="y"
             add 1 to ws-contador
             read fc-notas-temp into ws-read-nota
             at end
               move "y" to ws-eof
             not at end
               write fs-notas from ws-read-nota
           end-perform
           close fc-notas
           close fc-notas-temp.

       09-borrar-limpiar-temp.
           open output fc-notas-temp
           write fs-notas-temp from " "
           close fc-notas-temp.

       10-datos-ejemplo.
           move 0 to ws-contador
           move "n" to ws-eof
           open extend fc-notas
           open input fc-notas-ejemplo
           perform until ws-eof="y"
             add 1 to ws-contador
             read fc-notas-ejemplo into ws-read-nota
             at end
               move "y" to ws-eof
             not at end
               write fs-notas from ws-read-nota
           end-perform
           close fc-notas
           close fc-notas-ejemplo
           go to 05-bucle-principal.


       99-fin.
           stop run.

       END PROGRAM NOTAS001.
