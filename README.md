# PIPELINE E ANÁLISE DE QUESTÕES DO ENEM 2021-2025

**NOTA: Este projeto ainda está em construção.**

## Sobre o Projeto
Este projeto realiza a extração, tratamento, modelagem dimensional e visualização dos microdados do ENEM referentes aos anos de 2021 a 2025. O objetivo principal é identificar insights e padrões nas questões para auxiliar a preparação de estudantes.

## Perguntas norteadoras da análise
- Quais as competências e habilidades menos/mais cobradas (em frequência)?
- Quais as competências e habilidades menos/mais difíceis? As questões consideradas pelo TRI como mais difíceis são mesmo as que têm maior número de erro?
- Existe algum padrão de erro nas últimas questões da prova?
- Quais competências mais influenciam a nota da redação?
- Existe relação direta entre a nota da redação e a nota da prova de linguagens e códigos?

## Arquitetura do pipeline
O pipeline utiliza a **Arquitetura Medalhão** (Bronze, Prata e Ouro) integrada a um banco de dados colunar local (duckdb).

- **Storage / Ingestão:** Python + SQL + DuckDB
- **Prototipagem e testes:** Dbeaver
- **Modelagem dimensional:** Star Schema (Tabelas Fato e Dimensão)
- **Controle de versão e publicação:** Git & GitHub
- **Visualização:** <!-- a ser decidido -->

## 📂 Estrutura do Repositório
```text
Analise de questoes do ENEM 2021 - 2025/
├── data/              # [Ignorado no Git] Dados brutos direto da fonte
├── database/          # [Ignorado no Git] Arquivo do banco de dados DuckDB
├── graficos/          # Gráficos produzidos na análise final
├── notebooks/         # Jupyter notebooks utilizados para as análises
├── sql/               # Queries em SQL para ingestão e tratamento de dados
├── scripts/           # Códigos em Python do pipeline principal
├── main.py            # Script de orquestração do pipeline
├── .gitignore         # Regras de exclusão do git
├── requirements.txt   # Dependências do ambiente Python (a ser implementado)
└── README.md          # Documentação do projeto
```

## Estratégia de engenharia de dados

As tabelas desse estudo são muito grandes, na casa de milhões de linhas. Processar todas essas linhas realizando cálculos e a criação de novas tabelas em memória seria completamente inviável. Portanto, resolvemos utilizar um motor de banco de dados OLAP, e o escolhido foi o duckdb. Como esse tipo de motor de banco de dados é voltado especialmente para análises, podemos tirar proveito desse poder para viabilizar nosso projeto. O duckdb não salva dados em processamento na memória RAM, mas sim processa as tabelas em lotes e já salva esses lotes direto no banco.

Decidimos, portanto, construir todo o pipeline em cima do duckdb. Desde a arquitetura medalhão, com suas camadas, até a criação de tabelas mart que já estão completamente prontas para análise. Dessa maneira ficamos com um projeto organizado e delimitado. O pipeline cuida de todo o tratamento necessário e a parte de visualização se encarrega apenas da parte gráfica.

## Desafios encontrados e soluções aplicadas
- **Alteração na estrutura do arquivo fonte dos dados**: utilizei ```union_by_name=True``` como parâmetro na query para que as linhas fossem integradas pelo título da coluna, não pela posição.

- **Lista de habilidades em arquivo PDF**: Criação de uma tabela de habilidades em um arquivo .csv usando python (biblioteca pdfplumber).

- **Falta de correspondência entre tabelas de redação**: Uso de técnica unpivot para dividir cada redação em competências separadas. Join com matriz de referência de redação para cruzar cada competência com sua nota média.

## Construção da arquitetura medalhão
**Camada Bronze:**

Ingestão bruta dos CSVs do INEP usando coringa para múltiplos anos. Preservação da tipagem  VARCHAR para evitar perda de dados. Criação de arquivo .csv e posterior tabela com matriz de referência.

Tabelas: bronze_microdados (aprox. 20 milhões de linhas), bronze_itens (aprox. 28 mil linhas), bronze_matriz (120 linhas).

**Camada Silver:**

Tabela matriz de referência: Convertidos tipos visando melhor performance.

Tabela itens: Remoção de itens abandonados (questões anuladadas). Remoção de colunas não relevantes ao objetivo. 

Tabelas: silver_respostas (aprox. 14,4 milhões de linhas), silver_itens (aprox. 27,6 mil linhas), silver_matriz (120 linhas)

**Camada Gold:** (a ser implementada)