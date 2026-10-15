-- cria a tabela bronze da matriz de referência. Usa o csv criado a partir da extração do PDF. 

CREATE OR REPLACE TABLE bronze_matriz AS
SELECT * FROM read_csv(
    'data\externo\d_matriz_enem.csv',
    all_varchar=true,
    encoding='utf-8',
    sep=';',
    header=true
    )