import pandas as pd
import pdfplumber

pdf_path = "data/externo/matriz_referencia_enem.pdf" # caminho do pdf. A matriz de todos os anos é igual.
csv_output_path = "data/externo/d_matriz_enem.csv"

# Dicionário simples para identificar a área pela palavra-chave
areas_map = {
    "linguagens": "LC",
    "matemática": "MT",
    "ciências da natureza": "CN",
    "ciências humanas": "CH"
}

# matriz onde serão armazenados as habilidades
dados_matriz = [['sg_area','co_habilidade','habilidade_descricao']] # essa primeira linha será usada como cabeçalho pra criar o csv
habilidade_ativa = None  # Variável para "lembrar" a habilidade e acumular o texto. Sem ela o extrator só pega a primeira linha da descrição.

def salva_habilidade(texto_completo,sigla):
    if texto_completo == "":
        return
    primeira_palavra = texto_completo.split()[0]
    num_hab = int(primeira_palavra[1:]) # Pega só o número da habilidade
    texto_hab = texto_completo[len(primeira_palavra):].strip() # Pega todo o texto da linha, excluindo a primeira palavra (o HXX)
    # Remove os traços que ficaram perdidos no início do texto
    while texto_hab.startswith("-") or texto_hab.startswith("–"):
        texto_hab = texto_hab[1:].strip()
    # junta as características da habilidade em uma lista e salva essa lista na lista geral
    nova_habilidade = [sigla,num_hab,texto_hab.strip()]
    dados_matriz.append(nova_habilidade)

area_atual = "" 
texto_completo=""
inicio_texto=('matriz', 'competência', 'h')

with pdfplumber.open(pdf_path) as pdf:

    for page in pdf.pages[1:]: # percorrer cada página do pdf. Descarta a primeira página
        texto = page.extract_text() # extrair o texto da página
        if not texto: # se a página estiver em branco passa pra próxima.
            continue

        # Se a página começa com "anexo" é porque chegou na parte do documento que não será mais usada
        if texto.lower().startswith("anexo"):
            break
            
        for linha in texto.split('\n'): #divide o texto lido em linhas
            linha = linha.strip() #remove espaços em branco antes e depois da linha
            if linha=="":
                continue

            linha = linha.lower() # converte a linha toda em letras minúsculas

            # Identificar o tipo de texto
            # pega apenas a primeira "palavra" da linha para análise
            primeira_palavra = linha.split()[0]

            # conferir se a linha é continuação da linha de cima
            if not linha.startswith(inicio_texto): # tem que ser tupla senão o startswith não aceita
                texto_completo += " " + linha

            # conferir as quebras de linha
            # só existem 3 possibilidades
            # - Se começa com "matriz" é indicação de nova área. 
            elif primeira_palavra.startswith("matriz"):
                #salva o texto anterior (que contém a habilidade acima desse texto) na lista
                if texto_completo: # evita de salvar o primeiro texto completo nulo
                    salva_habilidade(texto_completo,sigla)
                # Atualizar a sigla da área do conhecimento.
                for nome_area, sigla in areas_map.items():
                    if nome_area in linha: # procura na linha o nome da área.
                        area_atual = sigla
                        texto_completo = ""
                        break

            # - Se começa com "competência" é indicação de nova competência
            elif primeira_palavra.startswith("competência"):
                #salva o texto anterior (que contém a habilidade acima desse texto) na lista
                # dados_matriz.append(texto_completo)
                salva_habilidade(texto_completo,sigla)
                #apaga o texto anterior que já foi salvo
                texto_completo = ""
                # salva o texto dessa competência
                texto_completo = linha
            
            # - Se começa com "HXX" é indicação de nova habilidade 
            elif primeira_palavra.upper().startswith("H") and primeira_palavra[1:].isdigit():
                # checa se o que está salvo é uma competência
                if not texto_completo.startswith('competência'):
                    #salva o texto anterior (que contém a habilidade acima desse texto) na lista SE não for uma competência
                    salva_habilidade(texto_completo, area_atual) #salvar a habilidade anterior
                texto_completo = "" #apaga o texto anterior que já foi salvo
                texto_completo = linha # salva o texto dessa linha

    # Salva a última habilidade processada ao fim do documento
    salva_habilidade(texto_completo,area_atual)

# salvar a matriz em um dataframe pandas
df_matriz = pd.DataFrame(dados_matriz[1:], # exclui a primeira linha, que será o nome das colunas
                        columns=dados_matriz[0]) # usa a primeira linha como nome das colunas
print(df_matriz)

# salvar o dataframe pandas em um arquivo csv
df_matriz.to_csv(csv_output_path, index=False, encoding="utf-8", sep=";")

print(f"Sucesso! {len(df_matriz)} habilidades salvas em {csv_output_path}")