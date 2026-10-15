## Orquestrar toda a criação e manutenção do banco de dados

# importar as funções de cada script
from scripts.bronze import executar_bronze
from scripts.silver import executar_silver

#função principal para chamar e orquestrar as funções das camadas
def rodar_pipeline_completo():
    print("Iniciando Pipeline de Dados - ENEM\n")

    # Executa as camadas
    # executar_bronze()
    executar_silver()

    print("Pipeline finalizado.")
#executar função principal
rodar_pipeline_completo()