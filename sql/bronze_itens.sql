CREATE OR REPLACE TABLE bronze_itens AS 
SELECT * 
FROM read_csv([
    'data/raw/microdados_enem_*/DADOS/ITENS_PROVA_*.csv' -- padrão de nomeclatura do arquivo. É igual para todos os anos.
],
    all_varchar = true, -- mantém todos os itens como varchar. Será arrumado na silver
    -- quote = '',           -- Evita que aspas perdidas no meio do texto quebrem a leitura
    escape = '', 
    null_padding = true,  -- Se uma linha tiver menos colunas que o normal, preenche com nulo em vez de dar erro
    ignore_errors = true, -- pula a linha se ela estiver completamente corrompida
    filename = true       -- para saber de qual arquivo veio o dado
);

-- os * são parte do motor do duckdb que consegue encontrar os arquivos com esse formato de nome e ler todos.