import duckdb 

def executar_gold():
    con=duckdb.connect('database/enem.duckdb') # abrir conexão com o banco

    try:
        # criar tabela com as competências da redação
        with open ('sql/03_gold/dim_competencias_redacao.sql', 'r', encoding='utf-8') as file:
            query = file.read()
        print("Criando a tabela dim_competencias_redacao")
        con.execute(query)
        print("Tabela de competências da redação criada com sucesso.\n")

        # criar a tabela final com as médias de cada competência da redação. Pronta para visualização.
        with open ('sql/03_gold/mart_redacao_final.sql', 'r', encoding='utf-8') as file:
            query=file.read()
        print("Criando a tabela mart_redacao")
        con.execute(query)
        print("Tabela de médias das competências da redação criada com sucesso.\n")

    except Exception as e: # caputrar erros e lançar no terminal
        print(f"Erro durante a criação da camada gold: \n{e}")

    finally: # com ou sem erro tem que fechar a conexão com o banco
        print("Conexão com o banco de dados encerrada")
        con.close()