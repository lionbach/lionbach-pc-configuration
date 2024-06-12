       IDENTIFICATION DIVISION.
       PROGRAM-ID.                PROG0003.
       AUTHOR.                    LIONBACH.
       INSTALLATION.              MI CASA.
       DATE-WRITTEN.              07/03/24.
       DATE-COMPILED.
       SECURITY.                  NO ES CONFIDENCIAL.
      * -------------------------------------------------------------- *
      * OBJETIVO: IMPRIMIR REPORTE DE EMPLEADOS                        *
      * -------------------------------------------------------------- *

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.           IBM-3080.
       OBJECT-COMPUTER.           IBM-3083.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLEADOS ASSIGN TO "04-EMPLEADOS".
      *     ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORTE   ASSIGN TO "04-REPORTE".
      *     ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
       FD  EMPLEADOS
      *     LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 50 CHARACTERS
           BLOCK CONTAINS 0 RECORDS.
      *     DATA RECORD US REG-EMPLEADOS.
       01  REG-EMPLEADOS          PIC X(50).
       FD  REPORTE
      *     LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 80 CHARACTERS
           BLOCK CONTAINS 0 RECORDS.
      *     DATA RECORD US REG-REPORTE.
       01  REG-REPORTE            PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-AREAS-A-USAR.
           05 WS-REG-EMPLEADOS.
               10 WS-NUMERO-EMP   PIC 9(05).               
               10 WS-NOMBRE-EMP   PIC X(30).
               10 WS-STATUS-EMP   PIC 9(01).
               10 WS-DEPTO-EMP    PIC 9(03).
               10 WS-PUESTO-EMP   PIC 9(02).
               10 WS-SALARIO-EMP  PIC 9(07)V99.
           05 WS-LEIDOS-EMP       PIC 9(05)    VALUE ZEROS.
           05 WS-IMPRESOS-EMP     PIC 9(05)    VALUE ZEROS.
           05 WS-TOT-SALARIOS     PIC 9(09)V99 VALUE ZEROS.

       01 WS-TITULO-1.
           05 FILLER              PIC X(29)    VALUE SPACES.
           05 WS-TIT-1            PIC X(22)
                                  VALUE "CENTRO DE CAPACITACION".
           05 FILLER              PIC X(29)    VALUE SPACES.

       01 WS-TITULO-2.
           05 FILLER              PIC X(08)    VALUE " FECHA: ".
           05 WS-TIT-2-DIA        PIC 9(02).
           05 FILLER              PIC X(01)    VALUE "/".
           05 WS-TIT-2-MES        PIC 9(02).
           05 FILLER              PIC X(01)    VALUE "/".
           05 WS-TIT-2-ANIO       PIC 9(04).
           05 FILLER              PIC X(11)    VALUE SPACES.
           05 WS-TIT-2            PIC X(23)
                                  VALUE "EMPLEADOS DE LA EMPRESA".
           05 FILLER              PIC X(15)    VALUE SPACES.
           05 FILLER              PIC X(8)     VALUE "PAGINA: ".
           05 WS-TIT-2-PAGINA     PIC ZZ9.
           05 FILLER              PIC X(02)    VALUE SPACES.

       01 WS-GUIONES.
           05 FILLER              PIC X(01).
           05 FILLER              PIC X(78)    VALUES ALL "-".
           05 FILLER              PIC X(01)    VALUE SPACES.

       01 WS-SUB-TITULO-1.
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 FILLER              PIC X(06)    VALUES "NUMERO".
           05 FILLER              PIC X(12)    VALUES SPACES.
           05 FILLER              PIC X(06)    VALUES "NOMBRE".
           05 FILLER              PIC X(15)    VALUES SPACES.
           05 FILLER              PIC X(06)    VALUES "STATUS".
           05 FILLER              PIC X(02)    VALUES SPACES.
           05 FILLER              PIC X(05)    VALUES "DEPTO".
           05 FILLER              PIC X(01)    VALUES SPACES.
           05 FILLER              PIC X(06)    VALUES "PUESTO".
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 FILLER              PIC X(07)    VALUES "SALARIO".
           05 FILLER              PIC X(06)    VALUES SPACES.

       01 WS-DETALLE.
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 WS-DET-NUMERO       PIC ZZZZ9.
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 WS-DET-NOMBRE       PIC X(30).
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 WS-DET-STATUS       PIC 9(01).
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 WS-DET-DEPTO        PIC 9(03).
           05 FILLER              PIC X(04)    VALUES SPACES.
           05 WS-DET-PUESTO       PIC 9(02).
           05 FILLER              PIC X(03)    VALUES SPACES.
           05 WS-DET-SALARIO      PIC Z,ZZZ,ZZ9.99.
           05 FILLER              PIC X(04)    VALUES SPACES.

       01 WS-DETALLE-LEIDOS.
           05 FILLER              PIC X(01).
           05 FILLER              PIC X(29)
                                  VALUE "TOTAL DE EMPLEADOS LEIDOS  : ".
           05 WS-TOT-LEIDOS       PIC ZZ,ZZ9.
           05 FILLER              PIC X(44)    VALUE SPACES.

       01 WS-DETALLE-IMPRESOS.
           05 FILLER              PIC X(01).
           05 FILLER              PIC X(29)
                                  VALUE "TOTAL DE EMPLEADOS IMPRESOS: ".
           05 WS-TOT-IMPRESOS     PIC ZZ,ZZ9.
           05 FILLER              PIC X(44)    VALUE SPACES.

       01 WS-DETALLE-SALARIO.
           05 FILLER              PIC X(01).
           05 FILLER              PIC X(29)
                                  VALUE "SUMA TOTAL DE SALARIOS     : ".
           05 WS-TOT-SALARIO      PIC $$$,$$$,$$9.99.
           05 FILLER              PIC X(36)    VALUE SPACES.

      * LINKAGE SECTION.
       01 LK-FECHA.
           05 FILLER              PIC X(02).
           05 LK-DIA              PIC 9(02) VALUE 08.
           05 LK-MES              PIC 9(02) VALUE 03.
           05 LK-ANIO             PIC 9(04) VALUE 2024.

      * PROCEDURE DIVISION USING LK-FECHA.
       PROCEDURE DIVISION.
       010-INICIO.
           OPEN INPUT  EMPLEADOS
                OUTPUT REPORTE
           WRITE REG-REPORTE FROM WS-TITULO-1
           MOVE LK-DIA TO WS-TIT-2-DIA
           MOVE LK-MES TO WS-TIT-2-MES
           MOVE LK-ANIO TO WS-TIT-2-ANIO
           MOVE 1 TO WS-TIT-2-PAGINA
           WRITE REG-REPORTE FROM WS-TITULO-2 AFTER ADVANCING 1
           WRITE REG-REPORTE FROM WS-GUIONES AFTER ADVANCING 1
           WRITE REG-REPORTE FROM WS-SUB-TITULO-1 AFTER ADVANCING 1
           WRITE REG-REPORTE FROM WS-GUIONES AFTER ADVANCING 1.
       020-LEE.
           READ EMPLEADOS INTO WS-REG-EMPLEADOS AT END
                GO TO 100-FIN.
           ADD 1                  TO WS-LEIDOS-EMP
           ADD WS-SALARIO-EMP     TO WS-TOT-SALARIOS
           MOVE WS-NUMERO-EMP     TO WS-DET-NUMERO
           MOVE WS-NOMBRE-EMP     TO WS-DET-NOMBRE
           MOVE WS-STATUS-EMP     TO WS-DET-STATUS
           MOVE WS-DEPTO-EMP      TO WS-DET-DEPTO
           MOVE WS-PUESTO-EMP     TO WS-DET-PUESTO
           MOVE WS-SALARIO-EMP    TO WS-DET-SALARIO
           WRITE REG-REPORTE FROM WS-DETALLE  AFTER ADVANCING 1
           ADD 1 TO WS-IMPRESOS-EMP
           GO TO 020-LEE.

       100-FIN.
           MOVE WS-LEIDOS-EMP TO WS-TOT-LEIDOS
           WRITE REG-REPORTE FROM WS-DETALLE-LEIDOS AFTER ADVANCING 2
           MOVE WS-IMPRESOS-EMP TO WS-TOT-IMPRESOS
           WRITE REG-REPORTE FROM WS-DETALLE-IMPRESOS AFTER ADVANCING 1
           MOVE WS-TOT-SALARIOS TO WS-TOT-SALARIO
           WRITE REG-REPORTE FROM WS-DETALLE-SALARIO AFTER ADVANCING 1
           CLOSE EMPLEADOS
                 REPORTE
           GOBACK.
