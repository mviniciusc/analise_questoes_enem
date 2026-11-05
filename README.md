# PIPELINE E ANÁLISE DE QUESTÕES DO ENEM 2021-2025

## Sobre o Projeto
Este projeto realiza a extração, tratamento, modelagem dimensional e visualização dos microdados do ENEM referentes aos anos de 2021 a 2025. O objetivo principal é identificar insights e padrões nas questões para auxiliar a preparação de estudantes.

## Perguntas norteadoras da análise
- Quais as competências e habilidades menos/mais cobradas (em frequência)?
- Quais as competências e habilidades menos/mais difíceis? As questões consideradas pelo TRI como mais difíceis são mesmo as que têm maior número de erro?
- Existe algum padrão de erro nas últimas questões da prova?
- Quais competências mais influenciam a nota da redação?
- Existe relação direta entre a nota da redação e a nota da prova de linguagens e códigos?

## Estrutura geral
O pipeline utiliza a **Arquitetura Medalhão** (Bronze, Prata e Ouro) integrada a um banco de dados colunar local (duckdb).

- **Storage / Ingestão:** Python + SQL + DuckDB
- **Prototipagem e testes:** Dbeaver
- **Modelagem dimensional:** Star Schema (Tabelas Fato e Dimensão) e tabelas mart
- **Controle de versão e publicação:** Git & GitHub
- **Visualização:** Python (bibliotecas pandas, matplotlib e seaborn)

## Estrutura do repositório
```text
Analise de questoes do ENEM 2021 - 2025/
├── data/              # [Ignorado no Git] Dados brutos direto da fonte
    ├── externo/       # Matriz de referência
    └── raw/           # Extração dos dados brutos
├── database/          # [Ignorado no Git] Arquivo do banco de dados DuckDB
├── graficos/          # Gráficos produzidos na análise final
├── notebooks/         # Jupyter notebooks utilizados para as análises
├── sql/               # Queries em SQL para ingestão e tratamento de dados
├── scripts/           # Códigos em Python do pipeline principal
├── main.py            # Script de orquestração do pipeline
├── .gitignore         # Regras de exclusão do git
├── requirements.txt   # Dependências do ambiente Python
└── README.md          # Documentação geral do projeto
```

## Arquitetura e engenharia de dados

As tabelas desse estudo são muito grandes, na casa de milhões de linhas. Processar todas essas linhas realizando cálculos e a criação de novas tabelas em memória seria completamente inviável. Portanto, resolvi utilizar um motor de banco de dados OLAP, e o escolhido foi o duckdb. Como esse tipo de motor de banco de dados é voltado especialmente para análises, podemos tirar proveito desse poder para viabilizar nosso projeto. O duckdb não salva dados em processamento na memória RAM, mas sim processa as tabelas em lotes e já salva esses lotes direto no banco.

Decidi, portanto, construir todo o pipeline em cima do duckdb. Desde a arquitetura medalhão, com suas camadas, até a criação de tabelas mart que já estão prontas para análise. Dessa maneira o projeto fica mais organizado e delimitado. O pipeline cuida de todo o tratamento necessário e a visualização se encarrega apenas da parte gráfica.

A camada bronze realiza a leitura de todos os arquivos .csv presentes na pasta. As tabelas resultantes são salvas diretamente no banco de dados, sem nenhum tipo de tratamento. Como não há uma tabela de matriz de referência na fonte oficial, fiz essa extração diretamente de arquivo PDF. Na camada prata realizei tratamentos de tipagem e filtragem de colunas que não serão utilizadas nas análises. Na camada ouro apliquei regras de manipulação de dados, incluindo criação de novas tabelas e colunas, para entregar os dados prontos para visualização. Os scripts em SQL estão disponíveis [nessa pasta](sql) e a orquestração em python está disponível [aqui](scripts).

Na parte de visualização e análise, cada pergunta inicial recebe um arquivo próprio. A estrutra desses arquivos é sempre a mesma, criando assim um pipeline de análise. Os notebook de análise estão disponíveis [nessa pasta](notebooks). Os gráficos foram criados usando bibliotecas python e forma escolhidos de acordo com a pergunta a ser respondida. Os gráficos produzidos estão disponíves em formato de imagem [nesse diretório](graficos).

## Desafios encontrados e soluções aplicadas
- **Alteração na estrutura do arquivo fonte dos dados**: utilizamos ```union_by_name=True``` como parâmetro na query para que as linhas fossem integradas pelo título da coluna, não pela posição.

- **Lista de habilidades em arquivo PDF**: Criamos uma tabela de habilidades em um arquivo .csv usando python (biblioteca pdfplumber) e extraindo dados direto do arquivo em PDF.

- **Falta de correspondência entre tabelas de redação**: Usamos técnica unpivot para dividir cada redação em competências separadas. Join com matriz de referência de redação para cruzar cada competência com sua nota média.

## Principais conclusões

Baseados nas perguntas estabelecidas inicialmente, tomamos algumas conclusões em nossas análises. É interessante notar a distribuição não-uniforme de pontos na redação, bem como a relação direta entre essa nota e a nota de linguagens e códigos. Essas observações permitem traçar melhores estratégias de preparação para a redação. Além disso, os diferentes níveis de dificuldade prevista entre as áreas do conhecimento chama nossa atenção para a forma como essas áreas devem ser abordadas ao longo do estudo. Estudo esse que também deve ser orientado visando as habilidades com maior presença na prova. A noção de distribuição de dificuldades se alia ao estudo sobre fadiga durante a prova para construírem uma observação valiosa sobre estratégia de prova e controle de ritmo, permitindo ao aluno mitigar os efeitos do cansaço e distribuir melhor seu tempo e atenção.

## Como reproduzir este projeto

Com o pipeline automatizado, esse projeto é de fácil reprodutibilidade. 

* Clone este repositório, via terminal, com `git clone https://github.com/mviniciusc/analise_questoes_enem.git` e acesse esse novo diretório com `cd analise_questoes_enem`
* Acesse a [fonte de dados do INEP](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem) e faça o download dos anos de interesse.
* Extraia todos os arquivos para a pasta [data/raw](data\raw).
* Dentro desses arquivos copie o matriz_referencia_enem.pdf para a pasta [data/externo](data\externo) (pode ser de qualquer ano, são todos iguais).
* instale as dependências necessárias com `pip install -r requirements.txt`.
* Execute o arquivo main.py. O pipeline de criação do banco de dados será executado automaticamente.