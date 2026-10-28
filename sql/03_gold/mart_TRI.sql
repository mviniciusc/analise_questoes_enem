-- Esse mart é para analisar como se relacionam a dificuldade prevista da questão (DIFICULDADE_TRI) e a dificuldade real que os alunos tiveram (TAXA_ACERTO)
CREATE OR REPLACE TABLE mart_tri AS
SELECT
	SI.CO_ITEM, -- Para identificar unicamente cada questão, evitar que duas questões de mesma habilidade que por acaso estejam na mesma posição sejam agrupadas
	SI.SG_AREA,
	SI.CO_HABILIDADE,
	SM.habilidade_descricao,
	SI.DIFICULDADE_TRI,
	ROUND(AVG(FR.ACERTO)*100,2) AS TAXA_ACERTO
FROM enem.main.gold_fato_respostas FR
JOIN enem.main.silver_itens SI
	ON FR.CO_PROVA = SI.CO_PROVA 
	AND FR.POSICAO = SI.CO_POSICAO 
JOIN enem.main.silver_matriz SM
	ON SI.SG_AREA  = SM.sg_area 
	AND SI.CO_HABILIDADE = SM.CO_HABILIDADE 
GROUP BY 
	SI.CO_ITEM, -- Pode ser usado também para identificar algum outlier que apareça na análise gráfica.
	SI.SG_AREA,
	SI.CO_HABILIDADE,
	SM.habilidade_descricao,
	SI.DIFICULDADE_TRI
ORDER BY 
	SI.SG_AREA,
	SI.CO_HABILIDADE