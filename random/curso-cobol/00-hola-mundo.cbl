      ******************************************************************
      *    Author: Leo Mumbach.
      *    Date: 21/11/2023.
      *    Comments:
      ******************************************************************
      *    IDENTIFICATION
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CURSO-01-HOLA-MUNDO.
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
       01 WS-SALUDO PIC X(16) VALUE "Hola Mundo!".
       LINKAGE SECTION.
      ******************************************************************
      *    PROCEDURE
      ******************************************************************
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY WS-SALUDO.
           STOP RUN.
       END PROGRAM CURSO-01-HOLA-MUNDO.
