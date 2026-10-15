CREATE OR REPLACE TABLE bronze_itens AS 
SELECT * 
FROM read_csv([
    'data/raw/microdados_enem_*/DADOS/ITENS_PROVA_*.csv' -- padrão de nomeclatura do arquivo. É igual para todos os anos.
],
    all_varchar = true, -- mantém todos os itens como varchar. Será arrumado na silver
    header=true, -- para usar a primeira linha como cabeçalho
    sep=';', -- delimitador de colunas
    encoding = 'latin-1', -- para ler corretamente as linhas. UTF-8 dá erro
    null_padding = true,  -- Se uma linha tiver menos colunas que o normal, preenche com nulo em vez de dar erro
    union_by_name=true, -- Para pesquisar pelo nome da coluna, não pela ordem
    filename = true       -- para saber de qual arquivo veio o dado
);

-- os * são parte do motor do duckdb que consegue encontrar os arquivos com esse formato de nome e ler todos.