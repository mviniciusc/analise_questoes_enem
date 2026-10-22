CREATE OR REPLACE TABLE mart_redacao AS
WITH redacoes_despivotadas AS (
    UNPIVOT (
        SELECT 
            REDACAO_COMP1, 
            REDACAO_COMP2, 
            REDACAO_COMP3, 
            REDACAO_COMP4, 
            REDACAO_COMP5
        FROM silver_respostas
        WHERE STATUS_REDACAO = 1
    )
    ON 
        REDACAO_COMP1, 
        REDACAO_COMP2, 
        REDACAO_COMP3, 
        REDACAO_COMP4, 
        REDACAO_COMP5
    INTO
        NAME competencia_nome
        VALUE nota_competencia
),
medias_calculadas AS(
SELECT 
	CAST(REPLACE(competencia_nome, 'REDACAO_COMP', '') AS INTEGER) AS id_competencia,
	ROUND(AVG(nota_competencia),2) AS media_nota
FROM redacoes_despivotadas 
GROUP BY id_competencia
)
SELECT 
	mc.id_competencia AS id,
	cr.descricao_competencia AS descricao,
	mc.media_nota AS nota_media
FROM enem.main.dim_competencias_redacao cr
JOIN medias_calculadas mc
ON cr.id_competencia = mc.id_competencia
ORDER BY mc.id_competencia