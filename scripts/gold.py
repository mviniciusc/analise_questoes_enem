import duckdb 

def executar_gold():
    con=duckdb.connect('database/enem.duckdb') # abrir conexão com o banco
    
    def criar_tabela(caminho, nome):
        # ativar o cálculo da barra de progresso e exibir no terminal
        con.execute("SET enable_progress_bar = true;")
        con.execute("SET enable_progress_bar_print = true;")
        with open(caminho, 'r', encoding='utf-8') as file:
            query=file.read()
        print(f'criando tabela {nome}')
        con.execute(query)
        print(f'Tabela {nome} criada com sucesso')

    try:
        # criar_tabela('sql/03_gold/gold_fato_respostas.sql', 'tabela-base') # criar tabela-base para análise das questões
        # criar_tabela('sql/03_gold/mart_frequencia.sql','mart_frequencia') # criar tabela final para análise da frequência de competências e habilidades
        # criar_tabela('sql/03_gold/mart_TRI.sql','mart_tri') # Criar tabela final para análise de dificuldade prevista x taxa de acerto
        # criar_tabela('sql/03_gold/mart_fadiga.sql','mart_fadiga') # criar tabela final para entender se o aluno "cansa" ao longo da prova e se isso impacta no desempenho
        # criar_tabela('sql/03_gold/dim_competencias_redacao.sql','dim_competencias_redacao') # criar tabela com as competências da redação
        # criar_tabela('sql/03_gold/mart_redacao.sql','mart_redacao') # criar a tabela final com as médias de cada competência da redação. Pronta para visualização.
        criar_tabela('sql/03_gold/mart_tendencia_redacao.sql', 'mart_tendencia_redacao') # criar a tabela cruzando nota da redação com nota de LC

    except Exception as e: # capturar erros e lançar no terminal
        print(f"Erro durante a criação da camada gold: \n{e}")

    finally: # com ou sem erro tem que fechar a conexão com o banco
        print("Conexão com o banco de dados encerrada")
        con.close()