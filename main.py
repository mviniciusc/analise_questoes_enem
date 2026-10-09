## Orquestrar toda a criação e manutenção do banco de dados

# importar as funções de cada script
from scripts.bronze import executar_bronze

#função principal para chamar e orquestrar as funções das camadas
def rodar_pipeline_completo():
    print("Iniciando Pipeline de Dados - ENEM\n")

    # Executa a Camada Bronze
    executar_bronze()

    print("Pipeline finalizado.")


#executar função principal
rodar_pipeline_completo()