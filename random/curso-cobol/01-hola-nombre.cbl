      ******************************************************************
      *    Author: Leo Mumbach.
      *    Date: //2023.
      *    Comments:
      ******************************************************************
      *    IDENTIFICATION
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. curso-02-hola-nombre.
       SECURITY.
      ******************************************************************
      *    ENVIRONMENT
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. pc.
       OBJECT-COMPUTER. pc.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      ******************************************************************
      *    DATA
      ******************************************************************
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 ws-saludo pic x(9) value "Hola Sr. ".
       01 ws-nombre pic x(16) value space.
       LINKAGE SECTION.
      ******************************************************************
      *    PROCEDURE
      ******************************************************************
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           display 'Ingrese su nombre:'.
           accept ws-nombre.
           display ws-saludo ws-nombre.
           STOP RUN.
       END PROGRAM curso-02-hola-nombre.
