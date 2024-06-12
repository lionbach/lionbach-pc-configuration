      * -------------------------------------------------------------- *
      * OBJETIVO: DESCRIPCION DEL PROGRAMA                             *
      * -------------------------------------------------------------- *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                PROG0005.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.

       01 WS-DATE.
           05 WS-DATE-ANIO        PIC 99.
           05 WS-MES              PIC 99.
           05 WS-DIA              PIC 99.
       
       01 WS-DAY.
           05 WS-DAY-ANIO         PIC 99.
           05 WS-DIAS-DEL-ANIO    PIC 999.
       
       01 WS-DAY-OF-WEEK          PIC 9.
       
       01 WS-TIME.
           05 WS-HORA             PIC 99.
           05 WS-MINUTO           PIC 99.
           05 WS-SEGUNDO          PIC 99.
           05 WS-MILISEGUNDO      PIC 99.

       01  WS-ACTUAL-DATE.
           05 WS-ACTUAL-FECHA.
               10  WS-ACTUAL-ANIO    PIC 9(4).
               10  WS-ACTUAL-MES     PIC 99.
               10  WS-ACTUAL-DIA     PIC 99.
           05 WS-ACTUAL-TIEMPO.
               10  WS-ACTUAL-HORA    PIC 99.
               10  WS-ACTUAL-MINUTO  PIC 99.
               10  WS-ACTUAL-SEGUNDO PIC 99.
               10  WS-ACTUAL-MS      PIC 99.
      *     05  WS-ACTUAL-GMT         PIC S9(4).
           05  WS-ACTUAL-GMT         PIC 9(5).


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           ACCEPT WS-DATE FROM DATE.
           DISPLAY "----- DATE -----".
           DISPLAY "VALOR: " WS-DATE.
           DISPLAY "INFO: ANIO MES DIA".
           DISPLAY "PIC:  99   99  99".
           DISPLAY "      "WS-DATE-ANIO "   " WS-MES "  " WS-DIA.
           DISPLAY " ".
           
           ACCEPT WS-DAY FROM DAY-OF-WEEK.
           DISPLAY "----- DAY -----".
           DISPLAY "VALOR: " WS-DAY.
           DISPLAY "INFO:  ANIO DIA-DEL-ANIO".
           DISPLAY "PIC:   99   999 ".
           DISPLAY "       " WS-DAY-ANIO "   " WS-DIAS-DEL-ANIO.
           DISPLAY " ".

           ACCEPT WS-DAY-OF-WEEK FROM DAY-OF-WEEK.
           DISPLAY "----- DAY-OF-WEEK -----".
           DISPLAY "VALOR: " WS-DAY-OF-WEEK.
           DISPLAY "INFO:  DIA-DE-LA-SEMANA".
           DISPLAY "PIC:   9".
           DISPLAY "       " WS-DAY-OF-WEEK.
           DISPLAY "INFO EXTRA: 1=LUN 2=MAR 3=MIE ... 7=DOM".
           DISPLAY " ".

           ACCEPT WS-TIME FROM TIME.
           DISPLAY "----- TIME -----".

           DISPLAY "VALOR: " WS-TIME.
           DISPLAY "INFO:  HORA MINUTO SEGUNDO MS".
           DISPLAY "PIC:   99   99     99      99".
           DISPLAY "       " WS-HORA "   " WS-MINUTO "     "
                   WS-SEGUNDO "      " WS-MILISEGUNDO.
           DISPLAY " ".

           MOVE FUNCTION CURRENT-DATE TO WS-ACTUAL-DATE.
           DISPLAY "----- FUNCTION CURRENT-DATE -----".
           DISPLAY "VALOR: " WS-ACTUAL-DATE.
           DISPLAY "INFO: 01  CURRENT-DATE".
           DISPLAY "      05  FECHA        TIEMPO          GMT".
           DISPLAY "      10  ANIO MES DIA HORA MIN SEG MS    ".
           DISPLAY "PIC:      9(4) 99  99  99   99  99  99 9(5)".
           DISPLAY "          "  WS-ACTUAL-ANIO " " WS-ACTUAL-MES
                   "  " WS-ACTUAL-DIA "  " WS-ACTUAL-HORA
                   "   " WS-ACTUAL-MINUTO "  " WS-ACTUAL-SEGUNDO
                   "  " WS-ACTUAL-MS " " WS-ACTUAL-GMT.
           DISPLAY " ".

           STOP RUN.
       END PROGRAM PROG0005.
