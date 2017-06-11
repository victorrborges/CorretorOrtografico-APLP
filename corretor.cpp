#include<iostream>
#include<string>
#include <vector>

using namespace std;

vector <string> dicionario;

void setup() {
	cout << "" << endl
			 << "Bem vindo ao Corretor Ortográfico!" << endl
			 << "Primeiramente, iremos configurar o dicionário." << endl
	     << "Digite as palavras que você deseja incluir no dicionário: " << endl
	     << "OBS: ao finalizar, digite \"end-dicionario\". " << endl;
	string entrada;
	while (entrada != "end-dicionario") {
		cin >> entrada;
		dicionario.push_back(entrada);
	}
}

void menuPrincipal() {
	cout << "=== Menu Principal ===" << endl
	     << "Escolha uma Opção:" << endl
			 << "1 - Corrigir texto" << endl
			 << "2 - Finalizar o programa" << endl;
	// Se 1, chamar corrigirTexto();
}

void corrigirTexto() {
	cout << "=== Correção de Textos ===" << endl
			 << "Digite o texto que você deseja corrigir: " << endl;
	// Ler o texto e guardar em uma variável (global?)
	// Chamar o varrerPalavras();
}

void varrerPalavras() {
	// Para cada palavra errada encontrada,
	// chamar o menuCorrecao();
}

void menuCorrecao() {
	// O print deve adicionar a palavra errada referente
	cout << "Palavra errada ----> " << endl << endl
			 << "1 - CORRIGIR" << endl
			 << "2 - ADICIONAR" << endl
			 << "3 - IGNORAR" << endl << endl
			 << "Escolha opção:" << endl;
}

void corrigir() {
	// Chamar o palavrasParecidas();
}

void palavrasParecidas() {
	// Listar as palaras parecidas e deixar o usuário escolher
}

void adicionar() {
	// Acrescentar a palavra no dicionario
}

int main () {
	setup();
	menuPrincipal();
	return (0);
}
