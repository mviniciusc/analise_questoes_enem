-- script da camada silver da tabela de itens
CREATE OR REPLACE TABLE silver_itens AS
    SELECT 
        CAST(CO_POSICAO AS INTEGER) AS CO_POSICAO,
        TRIM(SG_AREA) AS SG_AREA,
        CAST(CO_ITEM AS INTEGER) AS CO_ITEM,
        TRIM(TX_GABARITO) AS TX_GABARITO,
        CAST(CO_HABILIDADE AS INTEGER) AS CO_HABILIDADE,
        CAST(REPLACE(NU_PARAM_B, ',', '.') AS FLOAT) AS DIFICULDADE_TRI, -- Garantir que a conversão funcione no padrão americano
        CAST(CO_PROVA AS INTEGER) AS CO_PROVA,
        CAST(TP_LINGUA AS INTEGER) AS TP_LINGUA
    FROM enem.main.bronze_itens
    WHERE IN_ITEM_ABAN = '0' -- Exclui os itens anulados
    AND CO_ITEM IS NOT NULL -- Só pra garantir integridade


-- Colunas descartadas:
-- IN_ITEM_ABAN
-- TX_MOTIVO_ABAN
-- IN_ITEM_ADAPTADO
-- NU_PARAM_A
-- NU_PARAM_C
-- TX_COR (não precisa porque o código da prova já é diferente pra cada cor)