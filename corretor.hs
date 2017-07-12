import System.IO
import Data.List

menuDicionario :: String -> IO()
menuDicionario palavra
	| palavra == "end-dicionario" = putStr ""
	| otherwise = do
		escreverDicionario palavra
		palavra <- getLine
		menuDicionario palavra

lerDicionario :: IO()
lerDicionario = do
	contents <- readFile "dicionario.txt"
	putStr contents

salvarTexto :: IO()
salvarTexto = do
	texto <- getLine
	writeFile "texto.txt" texto

escreverDicionario :: String -> IO()
escreverDicionario palavra = do
	appendFile "dicionario.txt" palavra
	appendFile "dicionario.txt" " "

corrigirTexto :: IO()
corrigirTexto = do
	putStrLn "\nCORREÇÃO DE TEXTOS\n"
	putStrLn "Digite o texto que você deseja corrigir: "
	salvarTexto
	varrerPalavras

dividirTexto :: IO()
dividirTexto = do
	--texto <- readFile "texto.txt"
	--palavrasDoTexto <- splitOn " " texto
	putStr ""


varrerPalavras :: IO()
varrerPalavras = do
	dividirTexto

corrigir :: IO()
corrigir = do
	putStr ""

adicionar :: IO()
adicionar = do
	putStr ""	

menuCorrecao :: IO()
menuCorrecao = do
	putStrLn ""
	putStrLn "Palavra errada ----> "
	putStrLn "1 - CORRIGIR\n2 - ADICIONAR\n3 - IGNORAR\n\nEscolha uma opção: "
	opcao <- getLine
	if(opcao == "1") then corrigir
		else if (opcao == "2") then adicionar
			else if(opcao == "3") then putStr ""
				else putStrLn "Opção inválida"

menuPrincipal :: String -> IO()
menuPrincipal opcao
	| opcao == "1" = do
		corrigirTexto
		putStrLn "MENU PRINCIPAL\nEscolha uma Opção:\n1 - Corrigir texto\n2 - Finalizar o programa"
		opcao <- getLine
		menuPrincipal opcao
	| otherwise = putStr("")

primeiraVerificacao :: [Char] -> [Char] -> Bool
primeiraVerificacao x y
	| diferenca <= 2 = True
	| otherwise = False
	where diferenca = diferencaLista x y

diferencaLista :: [Char] -> [Char] -> Int
diferencaLista x y
	| xMaior = (length (x \\ y))
	| otherwise = (length (y \\ x))
	where xMaior = (length x) > (length y)

segundaVerificacao :: String -> String -> Bool
segundaVerificacao x y
	| (sort x == sort y) = True
	| otherwise = False

main = do
	putStrLn "CORRETOR ORTOGRAFICO!\n"
	putStrLn "Primeiramente, iremos configurar o dicionário.\nDigite as palavras que você deseja incluir no dicionário:\nobs: ao finalizar, digite \"end-dicionario\""
	palavra <- getLine
	menuDicionario palavra
	lerDicionario

	putStrLn "\nMENU PRINCIPAL\nEscolha uma Opção:\n1 - Corrigir texto\n2 - Finalizar o programa"

	opcao <- getLine
	menuPrincipal opcao
