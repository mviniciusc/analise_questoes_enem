# PIPELINE E ANÁLISE DE QUESTÕES DO ENEM 2021-2025

## Sobre o Projeto
Este projeto realiza a extração, tratamento, modelagem dimensional e visualização dos microdados do ENEM referentes aos anos de 2021 a 2025. O objetivo principal é identificar insights e padrões nas questões para auxiliar a preparação de estudantes.

## Arquitetura do pipeline
O pipeline utiliza a **Arquitetura Medalhão** (Bronze, Prata e Ouro) integrada a um banco de dados colunar local de alto desempenho.

- **Storage / Ingestão:** Python + SQL + DuckDB
- **Modelagem Dimensional:** Star Schema (Tabelas Fato e Dimensão)
- **Controle de Versão:** Git & GitHub
- **Visualização:** <!-- a ser decidido -->

## 📂 Estrutura do Repositório
```text
Analise de questoes do ENEM 2021 - 2025/
├── data/              # [Ignorado no Git] Dados brutos direto da fonte
├── database/          # [Ignorado no Git] Arquivo do banco de dados DuckDB
├── sql/               # Queries ingestão e tratamento de dados
├── scripts/           # Pipeline principal de orquestração Python
├── .gitignore         # Regras de exclusão do controle de versão
├── requirements.txt   # Dependências do ambiente Python
└── README.md          # Documentação do projeto
```