
CREATE OR REPLACE TABLE bronze_respostas AS 
SELECT * 
FROM read_csv([
    'data/raw/microdados_enem_*/DADOS/MICRODADOS_ENEM_*.csv', --modelo antigo até 2023
    'data/raw/microdados_enem_*/DADOS/RESULTADOS_*.csv'],  --modelo novo 2024 em diante
    all_varchar = true, -- manter todos como varchar, será corrigido na silver
    null_padding = true,  -- Se uma linha tiver menos colunas que o normal, preenche com nulo em vez de dar erro
    encoding = 'latin-1', -- para ler corretamente as linhas. UTF-8 dá erro
    union_by_name=true, -- Para pesquisar pelo nome da coluna, não pela ordem
    sep=';', -- delimitador de colunas
    header=true, -- para usar a primeira linha como cabeçalho
    filename = true -- para saber de qual arquivo veio o dado
);

-- os * são parte do motor do duckdb que consegue encontrar os arquivos com esse formato de nome e ler todos.