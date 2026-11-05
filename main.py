## Orquestrar toda a criação e manutenção do banco de dados

# importar as funções de cada script
from scripts.bronze import executar_bronze
from scripts.silver import executar_silver
from scripts.gold import executar_gold
from scripts.extrair_matriz import extrair_matriz

#função principal para chamar e orquestrar as funções das camadas
def rodar_pipeline_completo():
    print("Iniciando Pipeline de Dados - ENEM")

    # Executa as camadas
    extrair_matriz()
    executar_bronze()
    executar_silver()
    executar_gold()

    print("Pipeline finalizado.")
#executar função principal
rodar_pipeline_completo()