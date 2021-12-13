import numpy as np

def levenshtein(s1, s2):
  linhas = len(s1) + 1
  colunas = len(s2) + 1
  distancias = np.zeros((linhas, colunas), dtype=int)

  for i in range(1, linhas):
    for j in range(1, colunas):
      distancias[i][0] = i
      distancias[0][j] = j

  for coluna in range(1, colunas):
    for linha in range(1, linhas):
      if s1[linha - 1] == s2[coluna - 1]:
        custo = 0
      else:
        custo = 2
      
      distancias[linha][coluna] = min(distancias[linha -1][coluna] + 1,
                                      distancias[linha][coluna - 1] + 1,
                                      distancias[linha - 1][coluna - 1] + custo)

  return ((len(s1)+len(s2)) - distancias[linha][coluna]) / (len(s1)+len(s2))