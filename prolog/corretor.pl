
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

escolha_menu1(N):-
    (N == 1) -> converte_entrada;
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
-Converte tambem o conteudo do dicionario para um array de strings e chama
 o metodo primeira verificacao com esses dois arrays.
*/
converte_entrada:-
    open('entrada.txt', read, S),
    read_line_to_codes(S,X),
    string_to_atom(X, X1),
    split_string(X1, ' ', "", L),
    close(S),
    converte_dicionario(LD).
    /*primeira_verificacao(LD, L).*/

converte_dicionario(L):-
    open('dicionario.txt', read, S),
    read_line_to_codes(S,X),
    string_to_atom(X, X1),
    split_string(X1, ' ', " ", L),
    close(S).

primeira_verificacao([],[]):-
    /*
    -Mudar isso aqui, quando esse método receber uma lista vazia ele vai chamar a segunda verificação
    */
    halt.

primeira_verificacao([HD|TD], [H|T]):-
    write("Head da entrada:"),nl,
    write(H),nl.

:- initialization main.

main:-

    limpa_entrada,
    limpa_dicionario,
    cria_dicionario,
    cria_entrada,
    
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
