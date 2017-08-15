import System.IO
import Data.List

menuDicionario :: String -> IO()
menuDicionario palavra
	| palavra == "end-dicionario" = putStr ""
	| otherwise = do
		escreverDicionario palavra
		palavra <- getLine
		menuDicionario palavra

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
	imprimirTextoCorrigido

imprimirTextoCorrigido :: IO()
imprimirTextoCorrigido = do
	putStrLn "Texto após correção:"
	textoFinal <- readFile "textoCorrigido.txt"
	putStrLn textoFinal
	putStrLn "\n"
	limparArquivo "textoCorrigido.txt"
	limparArquivo "texto.txt"

limparArquivo :: String -> IO()
limparArquivo nomeArquivo = writeFile nomeArquivo ""
	

--verificar as palavras do texto, no dicionario
varrerPalavras :: IO()
varrerPalavras = do
	palavrasTexto <- readFile "texto.txt"
	palavrasDicionario <- readFile "dicionario.txt"
	let arrayTexto = (words palavrasTexto)
	let arrayDicionario = (words palavrasDicionario)
	verificarCorretude arrayTexto arrayDicionario
	

verificarCorretude :: [String] -> [String] -> IO()
verificarCorretude palavras dicionario
	| palavras == [] = putStrLn ""
	| otherwise = do
		if head palavras `elem` dicionario then
			salvarPalavraCorreta palavras dicionario 
			else 
			corrigirPalavra palavras dicionario

salvarPalavraCorreta :: [String] -> [String] -> IO()
salvarPalavraCorreta palavras dicionario = do
	appendFile "textoCorrigido.txt" (head palavras)
	appendFile "textoCorrigido.txt" " "
	verificarCorretude (tail palavras) dicionario

corrigirPalavra :: [String] -> [String] -> IO()
corrigirPalavra palavras dicionario
	|null palavras = putStr("")
	|otherwise = do
		let palavra = head palavras
		let opcoes = [x | x <- dicionario, segundaVerificacao x palavra || primeiraVerificacao x palavra]
		menuCorrecao palavra opcoes
		corrigirPalavra (tail palavras) dicionario
	

menuCorrecao :: String -> [String] -> IO()
menuCorrecao palavra opcoes
	|null opcoes = do
		adicionarAoTextoFinal(palavra)
		putStr "Você deseja adicionar \""
		putStr palavra
		putStrLn "\" ao dicionario?"
		putStrLn "1-Sim \n2-Nao"
		opcao <- getLine
		if(opcao == "1") then escreverDicionario palavra
		else putStrLn("")
	|otherwise = do
		putStr "Palavra errada ----> " 
		putStr palavra
		putStrLn("")
		putStrLn "Voce quis dizer "
		putStr(head opcoes)
		putStrLn "? \n1-Sim\n2-Nao" 
		opcao <- getLine
		if(opcao == "1") then adicionarAoTextoFinal (head opcoes)
		else menuCorrecao palavra (tail opcoes)

adicionarAoTextoFinal :: String -> IO()
adicionarAoTextoFinal palavra = do
	appendFile "textoCorrigido.txt" palavra
	appendFile "textoCorrigido.txt" " "

menuPrincipal :: String -> IO()
menuPrincipal opcao
	| opcao == "1" = do
		corrigirTexto
		putStrLn "MENU PRINCIPAL\nEscolha uma Opção:\n1 - Corrigir texto\n2 - Finalizar o programa"
		opcao <- getLine
		menuPrincipal opcao
	| otherwise = limparArquivo "dicionario.txt"

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

	putStrLn "\n\nMENU PRINCIPAL\nEscolha uma Opção:\n1 - Corrigir texto\n2 - Finalizar o programa"

	opcao <- getLine
	menuPrincipal opcao
