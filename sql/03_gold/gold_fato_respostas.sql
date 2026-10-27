-- Aqui é feito o fatiamento e união das respostas das questões.
-- Essa tabela é base para duas análises diferentes, por isso foi salva como ponto intermediário. 
CREATE OR REPLACE TABLE gold_fato_respostas AS
-- abrir o string com respostas e gabarito da prova LC
WITH LC AS (
	SELECT CO_PROVA_LC AS CO_PROVA, -- Não aparece mais o LC porque no final vai ficar tudo junto
	UNNEST(string_split(RESPOSTAS_LC,'')) AS RESPOSTA,
	UNNEST(string_split(GABARITO_LC,'')) AS GABARITO,
	UNNEST(generate_series(1,45)) AS POSICAO -- Provas de LC sempre começam da questão 1
	FROM enem.main.silver_respostas 
	WHERE PRESENTE_LC = 1
),
-- abrir o string com respostas e gabarito da prova CH
CH AS (
	SELECT CO_PROVA_CH AS CO_PROVA, -- Não aparece mais o CH porque no final vai ficar tudo junto
	UNNEST(string_split(RESPOSTAS_CH,'')) AS RESPOSTA,
	UNNEST(string_split(GABARITO_CH,'')) AS GABARITO,
	UNNEST(generate_series(46,90)) AS POSICAO -- Provas de CH sempre começam da questão 46
	FROM enem.main.silver_respostas 
	WHERE PRESENTE_CH = 1
),
-- abrir o string com respostas e gabarito da prova CN
CN AS (
	SELECT CO_PROVA_CN AS CO_PROVA, -- Não aparece mais o CN porque no final vai ficar tudo junto
	UNNEST(string_split(RESPOSTAS_CN,'')) AS RESPOSTA,
	UNNEST(string_split(GABARITO_CN,'')) AS GABARITO,
	UNNEST(generate_series(91, 135)) AS POSICAO -- Provas de CN sempre começam da questão 91
	FROM enem.main.silver_respostas 
	WHERE PRESENTE_CN = 1
),
-- abrir o string com respostas e gabarito da prova MT
MT AS (
	SELECT CO_PROVA_MT AS CO_PROVA, -- Não aparece mais o MT porque no final vai ficar tudo junto
	UNNEST(string_split(RESPOSTAS_MT,'')) AS RESPOSTA,
	UNNEST(string_split(GABARITO_MT,'')) AS GABARITO,
	UNNEST(generate_series(136, 180)) AS POSICAO -- Provas de MT sempre começam da questão 136
	FROM enem.main.silver_respostas 
	WHERE PRESENTE_MT = 1
),
--Juntar todas as CTEs acima
TABELAS_JUNTAS AS (
	SELECT * FROM LC
	UNION ALL
	SELECT * FROM CH
	UNION ALL
	SELECT * FROM CN
	UNION ALL
	SELECT * FROM MT
)
-- finalmente a criação da tabela em si
SELECT 
	CO_PROVA,
	POSICAO,
	CASE WHEN RESPOSTA = GABARITO THEN 1.0 ELSE 0.0 END AS ACERTO
FROM TABELAS_JUNTAS