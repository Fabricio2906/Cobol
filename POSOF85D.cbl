      ******************************************************************
      * Author:Fabricio
      * Date:15/12/2025
      * Purpose:Anti Fraude
      * Tectonics: cobc
      ******************************************************************
           IDENTIFICATION DIVISION.
           PROGRAM-ID. POSOF85D.

           ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           SPECIAL-NAMES.
               DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT TRANSACOES-FILE
               ASSIGN TO 'C:\Cobol\AntiFraude\transacao.txt'
                   ORGANIZATION IS LINE SEQUENTIAL.
               SELECT ALERTAS-FILE
               ASSIGN TO 'C:\Cobol\AntiFraude\alertas.txt'
                   ORGANIZATION IS LINE SEQUENTIAL.
           DATA DIVISION.
           FILE SECTION.

            FD  TRANSACOES-FILE.
       01  REG-TRANSACAO         PIC X(200).

       FD  ALERTAS-FILE.
       01  REG-ALERTA            PIC X(200).

       WORKING-STORAGE SECTION.

       01  WS-FIM-ARQ            PIC X VALUE 'N'.
           88 WS-EOF             VALUE 'S'.

       01  WS-TRANSACAO.
           05 WS-ID-CONTA        PIC X(6).
           05 WS-NOME-CLIENTE    PIC X(20).
           05 WS-TIPO-CONTA      PIC X(10).
           05 WS-VALOR-TXT       PIC X(10).
           05 WS-TIPO-OPERACAO   PIC X(10).

       01  WS-VALOR-NUM          PIC 9(7)V99.

       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-INICIALIZA
           PERFORM 2000-PROCESSA
           PERFORM 3000-FINALIZA
           STOP RUN.

      * ===============================
      * 1000 - INICIALIZAÇÃO
      * ===============================
       1000-INICIALIZA.
           OPEN INPUT TRANSACOES-FILE
                OUTPUT ALERTAS-FILE.
           EXIT.

      * ===============================
      * 2000 - PROCESSAMENTO
      * ===============================
       2000-PROCESSA.
           PERFORM UNTIL WS-EOF
               READ TRANSACOES-FILE
                   AT END
                       SET WS-EOF TO TRUE
                   NOT AT END
                       PERFORM 2100-TRATA-REGISTRO
               END-READ
           END-PERFORM.
           EXIT.

      * ===============================
      * 2100 - TRATAMENTO DO REGISTRO
      * ===============================
       2100-TRATA-REGISTRO.

           UNSTRING REG-TRANSACAO
               DELIMITED BY ";"
               INTO WS-ID-CONTA
                    WS-NOME-CLIENTE
                    WS-TIPO-CONTA
                    WS-VALOR-TXT
                    WS-TIPO-OPERACAO
           END-UNSTRING

           MOVE WS-VALOR-TXT TO WS-VALOR-NUM

           PERFORM 2200-VERIFICA-FRAUDE.
           EXIT.

      * ===============================
      * 2200 - REGRA DE FRAUDE
      * ===============================
       2200-VERIFICA-FRAUDE.
           IF (WS-TIPO-OPERACAO = "PIX"
               AND WS-VALOR-NUM > 10000,00)
              OR
              (WS-TIPO-OPERACAO = "TED"
               AND WS-VALOR-NUM > 25000,00)

               STRING
                   "ALERTA FRAUDE - CONTA: " WS-ID-CONTA
                   " | CLIENTE: " WS-NOME-CLIENTE
                   " | VALOR: " WS-VALOR-TXT
                   " | OPERACAO: " WS-TIPO-OPERACAO
                   DELIMITED BY SIZE
                   INTO REG-ALERTA
               END-STRING

               WRITE REG-ALERTA
           END-IF.
           EXIT.

      * ===============================
      * 3000 - FINALIZAÇÃO
      * ===============================
       3000-FINALIZA.
           CLOSE TRANSACOES-FILE
                 ALERTAS-FILE.
           EXIT.
