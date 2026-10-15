CREATE OR REPLACE TABLE silver_matriz AS
    SELECT 
        sg_area,
        cast(co_habilidade AS INT) AS co_habilidade, -- Interessante deixar como número inteiro por questões de performance
        habilidade_descricao
    FROM enem.main.bronze_matriz