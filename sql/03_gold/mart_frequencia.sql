-- Criação da tabela mart_frequencia que analisa quais as habilidades mais cobradas em frequência de aparição na prova.
SELECT 
    SI.SG_AREA,
    SI.CO_HABILIDADE,
    SM.habilidade_descricao,
    COUNT(DISTINCT CO_ITEM) AS quantidade_questoes
FROM enem.main.silver_itens SI
JOIN enem.main.silver_matriz SM
	ON SI.SG_AREA = SM.sg_area 
	AND SI.CO_HABILIDADE = SM.co_habilidade
GROUP BY 
    SI.SG_AREA,
    SI.CO_HABILIDADE, 
    SM.habilidade_descricao
ORDER BY
	SI.SG_AREA,
	quantidade_questoes DESC

-- OBS: A soma das ocorrências dá 2085 questões. A base inclui não apenas as 900 questões da aplicação regular mas também questões de provas como PPL, reaplicações e provas adaptadas.