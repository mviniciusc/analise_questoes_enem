# PIPELINE E ANÁLISE DE QUESTÕES DO ENEM 2021-2025

**NOTA: Este projeto ainda está em construção.**

## Sobre o Projeto
Este projeto realiza a extração, tratamento, modelagem dimensional e visualização dos microdados do ENEM referentes aos anos de 2021 a 2025. O objetivo principal é identificar insights e padrões nas questões para auxiliar a preparação de estudantes.

## Perguntas norteadoras da análise
- Quais as competências e habilidades menos/mais cobradas (em frequência)?
- Quais as competências e habilidades menos/mais difíceis (com mais erros)?
- Existe algum padrão de erro nas últimas questões da prova?
- Quais competências mais influenciam a nota da redação?
- Existe relação direta entre a nota da redação e a nota da prova de linguagens e códigos?

## Arquitetura do pipeline
O pipeline utiliza a **Arquitetura Medalhão** (Bronze, Prata e Ouro) integrada a um banco de dados colunar local de alto desempenho.

- **Storage / Ingestão:** Python + SQL + DuckDB
- **Prototipagem e testes:** Dbeaver
- **Modelagem Dimensional:** Star Schema (Tabelas Fato e Dimensão)
- **Controle de Versão:** Git & GitHub
- **Visualização:** <!-- a ser decidido -->

## 📂 Estrutura do Repositório
```text
Analise de questoes do ENEM 2021 - 2025/
├── data/              # [Ignorado no Git] Dados brutos direto da fonte
├── database/          # [Ignorado no Git] Arquivo do banco de dados DuckDB
├── sql/               # Queries para ingestão e tratamento de dados
├── scripts/           # Pipeline principal de orquestração Python
├── main.py            # Script de orquestração do pipeline
├── .gitignore         # Regras de exclusão do controle de versão
├── requirements.txt   # Dependências do ambiente Python (a ser implementado)
└── README.md          # Documentação do projeto
```

## Desafios encontrados e soluções aplicadas
- **Alteração na estrutura do arquivo fonte dos dados**: utilizei ```union_by_name=True``` como parâmetro na query para que as linhas fossem integradas pelo título da coluna, não pela posição.

- **Lista de habilidades em arquivo PDF**: Criação de uma tabela de habilidades em um arquivo .csv usando python (biblioteca pdfplumber).

## Construção da arquitetura medalhão
**Camada Bronze:**

Ingestão bruta dos CSVs do INEP usando coringa para múltiplos anos. Preservação da tipagem  VARCHAR para evitar perda de dados. Criação de arquivo .csv e posterior tabela com matriz de referência.

Tabelas: bronze_microdados (aprox. 20 milhões de linhas), bronze_itens (aprox. 28 mil linhas).

**Camada Silver:** (a ser implementada)

Tabela itens: Remoção de itens abandonados (questões anuladadas). Remoção de colunas não relevantes ao objetivo. 


**Camada Gold:** (a ser implementada)