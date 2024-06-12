      ******************************************************************
      *    Author:                Lionbach (Leo Mumbach)
      *    Date:                  01/01/2024
      *    Objetive:
      *    Comments:
      ******************************************************************

      ******************** IDENTIFICATION DIVISION *********************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                PROG0001.
       AUTHOR.                    LIONBACH.
       INSTALLATION.              HOME OFFICE.
       DATE-WRITTEN.              16/03/24.
       DATE-COMPILED.
       SECURITY.                  NO ES CONFIDENCIAL.

      ********************** ENVIRONMENT DIVISION **********************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.           PC.
       OBJECT-COMPUTER.           PC.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      ************************* DATA DIVISION **************************
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.

      *********************** PROCEDURE DIVISION ***********************
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY 'HELLO WORLD'.
           STOP RUN.
       END PROGRAM PROG0001.
