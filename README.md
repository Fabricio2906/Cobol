# Cobol
Mainframe/ COBOL
POSOF85D — Sistema de Detecção de Fraude (COBOL)
📌 Descrição

O POSOF85D é um programa COBOL responsável por processar registros de transações e gerar alertas de possíveis fraudes.
Ele lê um arquivo de transações, aplica regras de validação e grava as ocorrências suspeitas em um arquivo de saída.

O programa foi desenvolvido com foco em processamento batch e análise simples de dados transacionais.

⚙️ Tecnologias

COBOL

Compilador: cobc (GnuCOBOL)

Processamento de arquivos sequenciais

Separador de campos: ;

Configuração regional: decimal com vírgula

📂 Estrutura de Funcionamento

O fluxo do programa é dividido em três etapas principais:

1️⃣ Inicialização (1000-INICIALIZA)

Abre o arquivo de entrada de transações

Cria/abre o arquivo de saída de alertas

2️⃣ Processamento (2000-PROCESSA)

Lê cada registro do arquivo de transações

Para cada registro:

Realiza a separação dos campos (UNSTRING)

Aplica regras de análise antifraude

Se houver suspeita → grava no arquivo de alertas

3️⃣ Finalização (3000-FINALIZA)

Fecha todos os arquivos abertos

Finaliza o programa

📥 Entrada de Dados

O programa espera um arquivo de transações contendo registros separados por ;.

Exemplo de estrutura lógica do registro:

CAMPO1;CAMPO2;CAMPO3;...;CAMPO_N


Cada linha representa uma transação a ser analisada.

📤 Saída

O programa gera um arquivo contendo apenas os registros considerados suspeitos, formatados como registros de alerta.

▶️ Como Compilar

Usando GnuCOBOL:

cobc -x POSOF85D.cbl -o POSOF85D

▶️ Como Executar
./POSOF85D


Certifique-se de que o arquivo de transações esteja disponível no caminho esperado pelo programa.

🎯 Objetivo do Sistema

Automatizar análise básica antifraude

Processar grandes volumes de transações em batch

Gerar base de alertas para auditoria ou investigação

👤 Autor

Fabricio

📅 Data

15/12/2025
