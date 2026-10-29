-- Esse script cria a tabela mart_tendencia_redacao para entender se há relação entre a nota da redação e a nota de LC.
CREATE OR REPLACE TABLE mart_tendencia_redacao AS
SELECT 
	ROUND(AVG(NOTA_LC), 2) AS MEDIA_LC,
	REDACAO_NOTA
FROM enem.main.silver_respostas
WHERE 
	NOTA_LC IS NOT NULL
	AND REDACAO_NOTA IS NOT NULL 
GROUP BY 
	REDACAO_NOTA
ORDER BY 
	REDACAO_NOTA