#include<iostream>
#include<string>
#include <vector>

using namespace std;

vector <string> dicionario;
string texto;

void setup() {
	cout << "" << endl
			 << "CORRETOR ORTOGRÁFICO!" << endl
			 << "" << endl
			 << "Primeiramente, iremos configurar o dicionário." << endl
	     << "Digite as palavras que você deseja incluir no dicionário: " << endl
	     << "obs: ao finalizar, digite \"end-dicionario\". " << endl;
	string entrada;
	while (entrada != "end-dicionario") {
		cin >> entrada;
		dicionario.push_back(entrada);
	}
}

void menuPrincipal() {
	cout << "" << endl
	     << "MENU PRINCIPAL" << endl
			 << "" << endl
	     << "Escolha uma Opção:" << endl
			 << "1 - Corrigir texto" << endl
			 << "2 - Finalizar o programa" << endl;
	// Se 1, chamar corrigirTexto();
}

void corrigirTexto() {
	cout << "CORREÇÃO DE TEXTOS" << endl
	     << "" << endl
			 << "Digite o texto que você deseja corrigir: " << endl;
	getLine(cin,texto);
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
