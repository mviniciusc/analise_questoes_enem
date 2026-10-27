import duckdb 

def executar_gold():
    con=duckdb.connect('database/enem.duckdb') # abrir conexão com o banco
    # ativar o cálculo da barra de progresso e exibir no terminal
    con.execute("SET enable_progress_bar = true;")
    con.execute("SET enable_progress_bar_print = true;")

    try:
        # # criar tabela-base para análise das questões
        # with open('sql/03_gold/gold_fato_respostas.sql','r', encoding='utf-8') as file:
        #     query= file.read()
        # print('Criando tabela-base para análise de questões')
        # con.execute(query)
        # print('Tabela-base criada com sucesso.\n')

        # criar tabela final para análise da frequência de competências e habilidades
        with open('sql/03_gold/mart_frequencia.sql','r', encoding='utf-8') as file:
            query= file.read()
        print('Criando tabela mart_frequencia')
        con.execute(query)
        print('Tabela de frequência de habilidades criada com sucesso.\n')

        # # criar tabela com as competências da redação
        # with open ('sql/03_gold/dim_competencias_redacao.sql', 'r', encoding='utf-8') as file:
        #     query = file.read()
        # print("Criando a tabela dim_competencias_redacao")
        # con.execute(query)
        # print("Tabela de competências da redação criada com sucesso.\n")

        # # criar a tabela final com as médias de cada competência da redação. Pronta para visualização.
        # with open ('sql/03_gold/mart_redacao.sql', 'r', encoding='utf-8') as file:
        #     query=file.read()
        # print("Criando a tabela mart_redacao")
        # con.execute(query)
        # print("Tabela de médias das competências da redação criada com sucesso.\n")

    except Exception as e: # capturar erros e lançar no terminal
        print(f"Erro durante a criação da camada gold: \n{e}")

    finally: # com ou sem erro tem que fechar a conexão com o banco
        print("Conexão com o banco de dados encerrada")
        con.close()