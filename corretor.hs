import System.IO

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
	appendFile "dicionario.txt" "\n"

menuPrincipal :: String -> IO()
menuPrincipal opcao
	| opcao == "1" = do
		putStrLn("recebe texto")
		salvarTexto
		opcao <- getLine
		menuPrincipal opcao
	| otherwise = putStr("")




main = do
	putStrLn "CORRETOR ORTOGRAFICO!\n"
	putStrLn "Primeiramente, iremos configurar o dicionário.\nDigite as palavras que você deseja incluir no dicionário:\nobs: ao finalizar, digite \"end-dicionario\""
	palavra <- getLine
	menuDicionario palavra
	lerDicionario
	
	putStrLn "MENU PRINCIPAL\nEscolha uma Opção:\n1 - Corrigir texto\n2 - Finalizar o programa"
	
	opcao <- getLine
	menuPrincipal opcao
