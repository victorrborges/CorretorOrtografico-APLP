
/*
Apaga as palavras existentes no arquivo dicionario.txt
*/
limpa_dicionario:-
    tell('dicionario.txt'), write(''), told.


/*
Inclui a palavra no arquivo dicionario.txt
*/
insere_dicionario(A):-
    append('dicionario.txt'),
    write(A),
    write(" "),
    told,
    cria_dicionario.

/*
Compara se a palavra dada como entrada é a flag para o fim
do preenchimento do dicionario.
*/
compara_flag(A):-
    (A \= 'end-dicionario') -> insere_dicionario(A);
    write("Fim do Dicionario"), nl.

/*
-Captura a entrada para o dicionario e salva no arquivo dicionario.txt
*/
cria_dicionario:-
    write("Informe as palavras do dicionario, digite 'end-dicionario':"),nl,
    read_line_to_codes(user_input, A1),
    string_to_atom(A1, A),
    compara_flag(A).

/*
-Apaga as palavras existentes no arquivo entrada.txt
*/
limpa_entrada:-
    tell('entrada.txt'), write(''), told.
limpa_sugestoes:-
    tell('sugestoes.txt'), write(''), told.



/*
-Captura a entrada das palavras a serem corrigidas e as salva no arquivo entrada.txt
*/
cria_entrada:-
    write("Informe o texto a ser corrigido:"),nl,
    read_line_to_codes(user_input, A1),
    string_to_atom(A1, A),
    append('entrada.txt'),
    write(A),
    told.

adiciona_dicionario(A):-
    append('dicionario.txt'),
    write(A),
    write(" "),
    told.

escolha_menu1(N):-
    (N == 1) -> limpa_sugestoes,
		limpa_entrada,
		cria_entrada,
		converte_entrada;
    halt.

/*
-Menu de escolha sobre corrigir as palavras ou encerrar o programa
*/
menu1:-
    write("1 - Corrigir palavras"), nl,
    write("2 - Encerrar"),nl,
    read_line_to_codes(user_input, A1),
    string_to_atom(A1, A),
    atom_number(A, N),
    escolha_menu1(N).

/*
-Converte a entrada que eh feita toda em uma linha para um array de strings.
-Chama o metodo converte_dicionario
-Chama o metodo primeira_verificacao que inicia as verificacoes de tamanho das palavras
*/
converte_entrada:-
    open('entrada.txt', read, S),
    read_line_to_codes(S,X),
    string_to_atom(X, X1),
    split_string(X1, ' ', " ", L),
    close(S),
    converte_dicionario(LD),
    estaNoDicionario(LD, L).



estaNoDicionario([HD|TD],[]) :- imprimeTextoFinal(), nl,
				menu1.
estaNoDicionario([HD|TD],[HD|T]) :- salvaPalavra(HD), 
				converte_dicionario(LD),
				estaNoDicionario(LD,T).
estaNoDicionario([HD|TD],[H|T]) :- estaNoDicionario(TD, [H|T]).
estaNoDicionario([],[H|T]) :- converte_dicionario(LD),
			      primeiraVerificacao(LD, H),
			      estaNoDicionario(LD,T).

primeiraVerificacao([HD|TD], H) :- string_to_list(HD, HL),
				   string_to_list(H, L),
				   msort(HL,HS),
				   msort(L, LS),
				   realizaPrimeiraVerificacao(HS,LS, [HD|TD], H).

primeiraVerificacao([], H) :- converte_dicionario(LD), segundaVerificacao(LD,H).

realizaPrimeiraVerificacao(D, D, [HD|TD], H) :- write(H),
					   write(" voce quis dizer "),
					   write(HD), 
					   write("? 1sim 2nao"), nl,
					   read_line_to_codes(user_input, B1),
					   string_to_atom(B1, B),
				           atom_number(B, N),
					   repostaPrimeiraVerificacao(N, [HD|TD], H).


realizaPrimeiraVerificacao(D, T, [HD|TD], H) :- segundaVerificacao([HD|TD], H). 


repostaPrimeiraVerificacao(1, [HD|TD], H) :- salvaPalavra(HD). 
repostaPrimeiraVerificacao(2, [HD|TD], H) :- primeiraVerificacao(TD, H).


segundaVerificacao([HD|TD], H) :-  string_to_list(HD, HL),
				   string_to_list(H, L),
				   intersection(HL,L,IL),
				   subtract(HL,IL, RL),
				   string_to_list(A,RL),
				   length(IL, R),
    				   compara_tamanho(R,[HD|TD],H).
segundaVerificacao([], H) :- adicionarAoDicionario(H).

adicionarAoDicionario(H) :- write("Voce gostaria de adicionar "),
			   write(H), 
			   write(" ao dicionario? 1sim 2nao"), nl,
			   read_line_to_codes(user_input, B1),
			   string_to_atom(B1, B),
			   atom_number(B, N),
			   respostaAdicionarAoDicionario(N,H).

respostaAdicionarAoDicionario(1,H) :- adiciona_dicionario(H),
				     salvaPalavra(H).
respostaAdicionarAoDicionario(2,H) :- salvaPalavra(H).


repostaSegundaVerificacao(1, [HD|TD], H) :- salvaPalavra(HD). 
repostaSegundaVerificacao(2, [HD|TD], H) :- segundaVerificacao(TD, H).


compara_tamanho(R,[HD|TD],H) :- (R < 3) -> write(H),
					   write(" voce quis dizer "),
					   write(HD), 
					   write("? 1sim 2nao"), nl,
					   read_line_to_codes(user_input, B1),
					   string_to_atom(B1, B),
				           atom_number(B, N),
					   repostaSegundaVerificacao(N, [HD|TD], H).

compara_tamanho(R,[HD|TD],H) :- (R > 2) -> segundaVerificacao(TD, H).



salvaPalavra(D) :- append('sugestoes.txt'), write(D),write(" "), told.

imprimeTextoFinal() :- open('sugestoes.txt', read, S),
    			read_line_to_codes(S,X),
			string_to_atom(X, X1),
			write(X1).

/*
-Converte o conteudo do arquivo dicionario.txt em um array de strings
*/
converte_dicionario(L):-
    open('dicionario.txt', read, S),
    read_line_to_codes(S,X),
    string_to_atom(X, X1),
    split_string(X1, ' ', " ", L),
    close(S).

/*
-Inicia as verificacoes de tamanho entre as palavras
*/
primeira_verificacao(L,[]):- halt.
primeira_verificacao([],L):- halt.

primeira_verificacao([HD|TD], [H|T]):-
    verifica_tamanho(HD, [H|T]),
    primeira_verificacao(TD, [H|T]).



/*
-Esse metodo extrai o tamanho das palavras e invoca o metodo compara_tamanho
 para verificar se a diferenca na quantidade de caracteres estah na faixa aceitavel
*/
verifica_tamanho(HD,[]):-
    /*
    -Mudar isso aqui, quando esse método receber uma lista vazia 
     ele vai chamar a segunda verificação (EU ACHO).
    */
    halt.

verifica_tamanho(HD, [H|T]):-
    string_length(HD, SD),
    string_length(H, S),
    compara_tamanho(SD,S,HD,H),
    verifica_tamanho(HD, T).



/*
-Extrai a diferenca entre os tamanhos recebidos e invoca 
 a segunda verificacao caso seja possivel 
*/

 

:- initialization main.

main:-

    limpa_entrada,
    limpa_dicionario,
    limpa_sugestoes,
    cria_dicionario,
    menu1.

    /*
    -Corrigir:
        -Informar as palavras a serem corrigidas e salvar em entrada.txt
            -Verificações:
                -Tamanho (não pode exceder 2 letras)
                -Mesmas letras
            -Menu 2:
                -Corrigir palavra
                -Inserir a nova palavra no dicionario
                -Ignorar
    */

    /*
    -Menu 1 novamente
    */
