#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

vector <string> dicionario;
vector <string> palavrasDoTexto;
string texto;

void setup();
void dividirTexto();
bool pertenceAoDicionario(string palavra);
void varrerPalavras();
void corrigirTexto();
void menuPrincipal();
void menuCorrecao(string palavra);
void corrigir(string palavra);
void palavrasParecidas(string palavra);
void adicionar(string palavra);
bool primeiraVerificacao(string palavra, string palavraDoDicionario);
bool segundaVerificacao(string palavra, string palavraDoDicionario);


int main () {
	setup();
	menuPrincipal();
	return (0);
}

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
		cin.ignore();
		dicionario.push_back(entrada);
	}
	dicionario.pop_back();
}

void dividirTexto() {

	string delimiter = " ";

	size_t pos = 0;
	string token;
	while ((pos = texto.find(delimiter)) != std::string::npos) {
    		token = texto.substr(0, pos);
    		palavrasDoTexto.push_back(token);
    		texto.erase(0, pos + delimiter.length());
	}


}

bool pertenceAoDicionario(string palavra) {
	for (int i = 0; i < dicionario.size(); i++) {
		if(palavra == dicionario[i]) {
			return true;
		}
	}
	return false;
}

void varrerPalavras() {

	dividirTexto();

	for(int i = 0; i < palavrasDoTexto.size(); i++) {
		if(!pertenceAoDicionario(palavrasDoTexto[i])) {
			menuCorrecao(palavrasDoTexto[i]);
		}
	}
}

void corrigirTexto() {
	cout << "CORREÇÃO DE TEXTOS" << endl
	     << "" << endl
			 << "Digite o texto que você deseja corrigir: " << endl;
	//nao esta salvando a ultima palavra do texto
	getline (cin,texto);
	// Chamar o varrerPalavras();
	varrerPalavras();
}

void menuPrincipal() {
	int option;

	while(option != 2) {

		cout << "" << endl
	     	<< "MENU PRINCIPAL" << endl
				 << "" << endl
	     	<< "Escolha uma Opção:" << endl
				 << "1 - Corrigir texto" << endl
				 << "2 - Finalizar o programa" << endl;
		cin >> option;
		cin.ignore();


		switch (option) {

			case 1:
				corrigirTexto();
				break;
			case 2:
				return;
				break;
			default:
				cout << "Opção inválida" << endl;
				break;
		}
	}

}


void menuCorrecao(string palavra) {
	int option;
	// O print deve adicionar a palavra errada referente
	cout << "Palavra errada ----> " << endl << palavra << endl
			 << "1 - CORRIGIR" << endl
			 << "2 - ADICIONAR" << endl
			 << "3 - IGNORAR" << endl << endl
			 << "Escolha opção:" << endl;

			cin >> option;
	 		cin.ignore();

	 		switch (option) {

	 			case 1:
	 				corrigir(palavra);
	 				break;
	 			case 2:
	 				adicionar(palavra);
	 				break;
	 			default:
	 				cout << "Opção inválida" << endl;
	 				break;

	 		}
}

bool primeiraVerificacao(string palavra, string palavraDoDicionario) {
	int aux = abs(palavra.length() - palavraDoDicionario.length());
	int palavra1 = palavra.length();
	int palavra2 = palavraDoDicionario.length();
	int count;
	if (palavra1 > palavra2) {
		count = palavra1;
	} else {
		count = palavra2;
	}
	for (int i = 0; i < count; i++) {
		if(palavra[i] != palavraDoDicionario[i]) {
			aux++;
		}
	}
	if(aux > 2) {
		return false;
	} else {
		return true;
	}
}

bool segundaVerificacao(string palavra, string palavraDoDicionario) {
	int palavra1 = palavra.length();
	int palavra2 = palavraDoDicionario.length();

	if(palavra1 == palavra2) {

		for (int i = 0; i < palavra1; i++) {
			for (int j = 0; j < palavra1; j++) {
				if(palavra[i] == palavraDoDicionario[j]) {
					palavraDoDicionario[i] == '0';
				}
			}
		}

		for (int i = 0; i < palavraDoDicionario.length(); i++) {
			if(palavraDoDicionario[i] != '0') {
				return false;
			}
		}
		return true;

	} else {
		return false;
	}

}

void corrigir(string palavra) {
	palavrasParecidas(palavra);
}

void palavrasParecidas(string palavra) {
	vector <string> parecidas;

	for (int i = 0; i < dicionario.size(); i++) {
		if(primeiraVerificacao(palavra, dicionario[i]) || segundaVerificacao(palavra, dicionario[i])) {
			parecidas.push_back(dicionario[i]);
		}
	}

	for (int i = 0; i < parecidas.size(); i++) {
		cout << i + 1 <<". "<< parecidas[i]<< endl;
	}

}

void adicionar(string palavra) {
	dicionario.push_back(palavra);
}
