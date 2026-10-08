CREATE OR REPLACE TABLE bronze_respostas AS 
SELECT * 
FROM read_csv_auto([
    'data/raw/microdados_enem_*/DADOS/MICRODADOS_ENEM_*.csv', --modelo antigo até 2023
    'data/raw/microdados_enem_*/DADOS/RESULTADOS_*.csv',  --modelo novo 2024 em diante
    all_varchar = true, -- manter todos como varchar, será corrigido na silver
    filename = true -- para saber de qual arquivo veio o dado
]);

-- os * são parte do motor do duckdb que consegue encontrar os arquivos com esse formato de nome e ler todos.