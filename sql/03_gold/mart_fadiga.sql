-- Esse script cria a tabela mart_fadiga que analisa se a taxa de erro das questões cresce ao longo da prova.
CREATE OR REPLACE TABLE mart_fadiga AS
SELECT 
	CASE -- Diferenciar o dia da prova para traçar 2 gráficos distintos.
		WHEN SI.SG_AREA IN ('CH', 'LC') THEN 'Dia 1'
		WHEN SI.SG_AREA IN ('MT', 'CN') THEN 'Dia 2'
	END AS DIA_PROVA,
	CASE  -- Ajustar a contagem da posição para reinicar no segundo dia.
		WHEN SI.SG_AREA IN ('MT', 'CN') THEN SI.CO_POSICAO-90
		ELSE SI.CO_POSICAO
	END AS POSICAO_DIA,
	ROUND(AVG(FR.ACERTO)*100,2) AS TAXA_ACERTO, -- A taxa de acerto média da questão naquela posição
	ROUND(AVG(SI.DIFICULDADE_TRI), 4) AS MEDIA_DIFICULDADE -- A média de dificuldade da questão naquela posição
FROM enem.main.gold_fato_respostas FR
JOIN enem.main.silver_itens SI
	ON FR.CO_PROVA = SI.CO_PROVA 
	AND FR.POSICAO = SI.CO_POSICAO
GROUP BY
	DIA_PROVA,
	POSICAO_DIA
ORDER BY 
	DIA_PROVA,
	POSICAO_DIA