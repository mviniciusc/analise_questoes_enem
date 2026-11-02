-- Cria uma tabela com as competências da redação
-- são apenas 5, não há necessidade de criar script para extrair de um PDF.

CREATE OR REPLACE TABLE dim_competencias_redacao AS 
    SELECT 
        CAST(id_competencia AS INTEGER) AS id_competencia,
        descricao_competencia,  -- Descrição completa como está no manual da redaçaõ
        nome_competencia -- Nome simplificado para visualização gráfica
    FROM (
        VALUES 
            (1, 'Demonstrar domínio da modalidade escrita formal da língua portuguesa.', 'Domínio da escrita formal'),
            (2, 'Compreender a proposta de redação e aplicar conceitos das várias áreas do conhecimento para desenvolver o tema, dentro dos limites estruturais do texto dissertativo-argumentativo em prosa.', 'Compreensão da proposta'),
            (3, 'Selecionar, relacionar, organizar e interpretar informações, fatos, opiniões e argumentos em defesa de um ponto de vista.', 'Organização dos argumentos'),
            (4, 'Demonstrar conhecimento dos mecanismos linguísticos necessários para a construção da argumentação.', 'Coesão e mecanismos lógicos'),
            (5, 'Elaborar proposta de intervenção para o problema abordado, respeitando os direitos humanos.', 'Proposta de intervenção')
    ) AS t(id_competencia, descricao_competencia, nome_competencia);