import duckdb 

def executar_silver():
    print("Iniciando criação das camadas 'silver'")

    # criar a conexão com o banco
    con = duckdb.connect('database/enem.duckdb')

    try:
        # criar a camada silver da tabela de itens
        with open('sql/02_silver/silver_itens.sql', 'r', encoding='utf-8') as file: # leitura do código sql para a camada prata.
            query_matriz = file.read()
        print("Executando a criação da camada silver_itens.")
        con.execute(query_matriz)
        total_itens = con.execute("SELECT COUNT(*) FROM bronze_respostas;").fetchone()[0] #pegar a "tabela" retornada pela query e usar apenas o número na primeira célula
        print(f"Tabela silver_itens criada com sucesso com {total_itens} linhas.")

        # criar a camada silver da tabela da matriz de referência
        with open('sql/02_silver/silver_matriz.sql', 'r', encoding='utf-8') as file: # leitura do código sql para a camada prata.
            query_matriz = file.read()
        print("Executando a criação da camada silver_matriz.")
        con.execute(query_matriz)
        print("Tabela silver_matriz criada com sucesso.")

    except Exception as e: # caputrar erros e lançar na tela
        print(f"Erro durante a criação da camada silver: \n{e}")

    finally: # com ou sem erro tem que fechar a conexão com o banco
        print("Fim do script, encerrando conexão com o banco de dados.")
        con.close()