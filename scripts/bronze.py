import os
import duckdb

def executar_bronze():
    print("Iniciando a ingestão da Camada Bronze...")
    
    # Garante que a pasta "database" existe antes de tentar criar o banco. Se já existir não faz nada.
    os.makedirs("database", exist_ok=True)
    
    # Cria (se não existir) o arquivo do banco de dados e abre conexão com ele
    con = duckdb.connect("database/enem.duckdb")
    
    try:
        # Ingestão da Tabela de Respostas

        #abre o sql com a query de criação da tabela de respostas, lê a query e armazena na variável
        with open("sql/bronze_respostas.sql", "r", encoding="utf-8") as file:
            query_respostas = file.read()
            
        print("Processando arquivos de respostas")
        con.execute(query_respostas) #executa a query bronze_respostas

        #conferir se deu certo e quantas linhas foram criadas
        total_resp = con.execute("SELECT COUNT(*) FROM bronze_respostas;").fetchone()[0] #pegar a "tabela" retornada pela query e usar apenas o número na primeira célula
        print(f"Tabela 'bronze_respostas' finalizada! Total de linhas: {total_resp:,}")

        # Ingestão da Tabela de Itens

        #abre o sql com a query de criação da tabela de respostas, lê a query e armazena na variável
        with open("sql/bronze_itens", "r", encoding="utf-8") as file:
            query_itens = file.read()
            
        print("Processando arquivos de Itens da Prova")
        con.execute(query_itens) #executa a query bronze_itens
        
        total_itens = con.execute("SELECT COUNT(*) FROM bronze_itens;").fetchone()[0] #pegar a "tabela" retornada pela query e usar apenas o número na primeira célula
        print(f"Tabela 'bronze_itens' finalizada! Total de linhas: {total_itens:,}")

    #se der erro:
    except Exception as e:
        print(f"Erro durante a ingestão da Camada Bronze:\n{e}")

    # Com ou sem erro
    finally:
        # não esqueça de fechar conexão
        con.close()
        print("Conexão com o DuckDB encerrada.")