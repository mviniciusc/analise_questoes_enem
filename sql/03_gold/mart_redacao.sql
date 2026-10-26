-- Tabela final com a análise da redação por competência

CREATE OR REPLACE TABLE mart_redacao AS
WITH redacoes_despivotadas AS (
    UNPIVOT ( -- Transforma as colunas em linhas para permitir análise e cruzamento com outras tabelas
        SELECT 
            REDACAO_COMP1, 
            REDACAO_COMP2, 
            REDACAO_COMP3, 
            REDACAO_COMP4, 
            REDACAO_COMP5
        FROM silver_respostas
        WHERE STATUS_REDACAO = 1 -- Usar somente as redações válidas
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
	CAST(REPLACE(competencia_nome, 'REDACAO_COMP', '') AS INTEGER) AS id_competencia, -- Usar apenas o número da competência. Para fins de controle e identificação
	ROUND(AVG(nota_competencia),2) AS media_nota -- Média das notas em cada competência
FROM redacoes_despivotadas 
GROUP BY id_competencia
)
-- Cruzar com a tabela que contém a descrição das competências para atribuir cada média a sua descrição.
SELECT 
	mc.id_competencia AS id,
	cr.descricao_competencia AS descricao,
	mc.media_nota AS nota_media
FROM enem.main.dim_competencias_redacao cr
JOIN medias_calculadas mc
ON cr.id_competencia = mc.id_competencia
ORDER BY mc.id_competencia