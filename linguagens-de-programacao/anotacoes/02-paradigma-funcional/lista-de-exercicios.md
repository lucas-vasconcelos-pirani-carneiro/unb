# Lista de Exercício - Haskell/Hugs

116343 Linguagens de Programação

EXEMPLOS DE TAREFAS PARA PROGRAMAÇÃO EM HUGS

(Obs.: o valor entre parênteses ilustra o grau de dificuldade da tarefa)


1.	Escreva uma função que receba uma lista de 4 elementos e verifique se todos os elementos são iguais.  (1,0)
2.	Escreva uma função que calcule o resto de uma divisão de dois números inteiros.    (0,5)
3.	Utilize recursão para criar uma função que calcule 2n.       (0,5)
4.	Escreva uma função que calcule o dobro da soma dos elementos de uma lista.     (0,5)
5.	Crie uma função que retorne a lista de todos os divisores de um dado número.     (1,0)
6.	Escreva uma função que verifique se duas listas possuem os mesmos elementos (a ordem não importa). (1,0)
7.	Escreva uma função que retorne o número de vezes que um dado elemento aparece numa lista.   (1,0)
8.	Escreva uma função que receba uma lista de números e retorne uma tupla com uma lista dos números pares e uma lista dos números ímpares.          (1,5) 
Ex:  funcao [1,2,3]
	([2],[1,3])
9.	Escreva uma função que verifique se um ano é bissexto.       (0,5)
10.	Escreva uma função que verifique se um ponto (x,y) está dentro de uma circunferência de raio R e com centro localizado num ponto (a,b).          (1,0)
11.	Crie uma função que gere os números primos menores que um dado número    (2,5)
12.	Escreva uma função que receba uma lista e a transforme em palíndrome.     (1,0) 
Ex: transforma [1,2]
	[1,2,2,1]
13.	Escreva uma função que receba uma lista e retorne o número de elementos que estão acima da média dos valores da lista.            (2,0)
14.	Escreva uma função que receba os coeficientes “a”, “b” e “c” da entrada padrão (teclado) e calcule as raízes da equação ax2+bx+c.           (2,0)
15.	Escreva uma função que receba uma lista e retorne a posição de um dado elemento nessa lista, iniciando da posição 0.           (1,0)
16.	Escreva uma função que receba uma string com o nome de um arquivo e retorne a extensão daquele arquivo (considere que a extensão vem depois do último ponto).
Ex: extensao “prova_de_hugs.doc.pdf”        (1,5)
	“.pdf”
extensao “unknown”
	(Você decide)
17.	Escreva uma função que encontre todos os nomes em uma dada frase, começando com letra maiúscula, e o restante do nome em letra minúscula.        (1,5)
18.	Escreva uma função que quebre uma string em duas partes no ponto onde estiver uma “/” e retorne uma tupla com as duas partes.          (2,0)
Ex: quebra “oi/tudo bem?”
	(“oi”, “tudo bem?”)
quebra “/tudo bem”
	([],”tudo bem”)
19.	Crie uma função que substitua uma dada palavra por outra em uma frase. Se a palavra não estiver contida na frase, deverá retornar a frase original.         (1,5)
Ex: subs “Senna” “Vettel” “Senna é o tricampeão de Fórmula 1 mais jovem!”
	“Vettel é o tricampeão de Fórmula 1 mais jovem!”

